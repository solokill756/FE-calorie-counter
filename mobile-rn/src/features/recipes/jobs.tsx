import AsyncStorage from '@react-native-async-storage/async-storage';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { randomUUID } from 'expo-crypto';
import { createContext, type PropsWithChildren, useContext, useEffect, useRef, useState } from 'react';
import { AppState } from 'react-native';
import { useSession } from '../account/session';
import type { Meal } from '../diary/api';
import { notifyRecipeStatus } from '../notifications/native';
import { createRecipeApi, type RecipeDraft, recipeFromGeneration } from './api';
import { createDraftStore, type DraftState } from './draft-store';

type RecipeJob = ReturnType<typeof useRecipeJobValue>;
const Context = createContext<RecipeJob | null>(null);
const drafts = createDraftStore(AsyncStorage);

function useRecipeJobValue() {
  const { api, profile } = useSession();
  const owner = profile?.id;
  const client = useQueryClient();
  const [record, setRecord] = useState<DraftState | null | undefined>(owner ? undefined : null);
  const [recoveryError, setRecoveryError] = useState<unknown>();
  const service = createRecipeApi(api);
  const lifetime = useRef<AbortController>(null);

  useEffect(() => {
    const controller = new AbortController();
    lifetime.current = controller;
    if (owner) {
      void drafts.read(owner).then((saved) => {
        if (!controller.signal.aborted) setRecord(saved);
      }).catch((error: unknown) => {
        if (controller.signal.aborted) return;
        setRecoveryError(error);
        setRecord(null);
      });
    }
    return () => controller.abort();
  }, [owner]);

  function activeSignal() {
    const signal = lifetime.current?.signal;
    if (!signal || signal.aborted) throw new Error('Recipe session ended.');
    return signal;
  }

  async function notify(jobId: string, title: string, body: string, recipeId?: number) {
    if (owner && AppState.currentState !== 'active' && !lifetime.current?.signal.aborted) {
      await notifyRecipeStatus({ ownerId: owner, kind: 'recipe', jobId, title, body, recipeId }).catch(() => undefined);
    }
  }

  const save = useMutation({
    mutationFn: async ({ jobId, draft }: { jobId: string; draft: RecipeDraft }) => {
      if (!owner) throw new Error('Sign in before saving recipes.');
      return { jobId, recipe: await service.save(draft, undefined, activeSignal()) };
    },
    onSuccess: async ({ jobId, recipe }) => {
      if (!owner || lifetime.current?.signal.aborted) return;
      const next: DraftState = { state: 'saved', jobId, recipeId: recipe.id, name: recipe.name };
      setRecord(next);
      await drafts.write(owner, next).catch(setRecoveryError);
      await client.invalidateQueries({ queryKey: ['recipes'] });
      await notify(jobId, 'Recipe ready', recipe.name, recipe.id);
    },
    onError: (_, { jobId }) => notify(jobId, 'Recipe could not be saved', 'Open Recipes to retry saving the draft.'),
  });

  const generate = useMutation({
    mutationFn: async ({ foodIds, meal, date }: { foodIds: number[]; meal: Meal; date: string }) => {
      if (!owner) throw new Error('Sign in before generating recipes.');
      const jobId = randomUUID();
      const signal = activeSignal();
      setRecoveryError(undefined);
      await drafts.write(owner, { state: 'generating', jobId });
      setRecord({ state: 'generating', jobId });
      try {
        const result = await service.generate(foodIds, meal, date, undefined, signal);
        const next = { state: 'draft' as const, jobId, draft: recipeFromGeneration(result, date, meal) };
        await drafts.write(owner, next);
        return next;
      } catch (error) {
        if (!signal.aborted) {
          await drafts.clear(owner).catch(setRecoveryError);
          setRecord(null);
          await notify(jobId, 'Recipe generation failed', 'Open Recipes and try again.');
        }
        throw error;
      }
    },
    onSuccess: (value) => {
      if (lifetime.current?.signal.aborted) return;
      setRecord(value);
      save.mutate(value);
    },
  });

  function retryDraft() {
    if (record?.state === 'draft' && !save.isPending) save.mutate(record);
  }

  async function discard() {
    if (!owner || generate.isPending || save.isPending) return;
    try {
      await drafts.clear(owner);
      setRecord(null);
      save.reset();
      generate.reset();
    } catch (error) {
      setRecoveryError(error);
    }
  }

  return {
    ready: record?.state === 'saved' ? record.name : undefined,
    draft: record?.state === 'draft' ? record.draft : undefined,
    interrupted: record?.state === 'generating' && !generate.isPending,
    busy: record === undefined || generate.isPending || save.isPending,
    error: generate.error ?? save.error ?? recoveryError,
    generate: generate.mutate,
    retryDraft,
    discard: () => void discard(),
  };
}

export function RecipeJobProvider({ children }: PropsWithChildren) {
  return <Context.Provider value={useRecipeJobValue()}>{children}</Context.Provider>;
}

export function useRecipeJob() {
  const job = useContext(Context);
  if (!job) throw new Error('RecipeJobProvider is missing.');
  return job;
}
