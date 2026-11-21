import { useMutation, useQueryClient } from '@tanstack/react-query';
import { createContext, type PropsWithChildren, useContext, useEffect, useRef, useState } from 'react';
import { AppState } from 'react-native';
import { useSession } from '../account/session';
import type { Meal } from '../diary/api';
import { notifyRecipeReady } from '../notifications/native';
import { createRecipeApi, type RecipeDraft, recipeFromGeneration } from './api';

type RecipeJob = ReturnType<typeof useRecipeJobValue>;
const Context = createContext<RecipeJob | null>(null);

function useRecipeJobValue() {
  const { api } = useSession();
  const client = useQueryClient();
  const [draft, setDraft] = useState<RecipeDraft>();
  const [ready, setReady] = useState<string>();
  const service = createRecipeApi(api);
  const lifetime = useRef<AbortController>(null);
  useEffect(() => {
    const controller = new AbortController();
    lifetime.current = controller;
    return () => controller.abort();
  }, []);

  function activeSignal() {
    const signal = lifetime.current?.signal;
    if (!signal || signal.aborted) throw new Error('Recipe session ended.');
    return signal;
  }
  const save = useMutation({
    mutationFn: (value: RecipeDraft) => service.save(value, undefined, activeSignal()),
    onSuccess: async (value) => {
      setDraft(undefined);
      setReady(value.name);
      await client.invalidateQueries({ queryKey: ['recipes'] });
      if (AppState.currentState !== 'active') await notifyRecipeReady(value.name).catch(() => undefined);
    },
  });
  const generate = useMutation({
    mutationFn: async ({ foodIds, meal, date }: { foodIds: number[]; meal: Meal; date: string }) => {
      setReady(undefined);
      const result = await service.generate(foodIds, meal, date, undefined, activeSignal());
      return recipeFromGeneration(result, date, meal);
    },
    onSuccess: (value) => {
      if (lifetime.current?.signal.aborted) return;
      setDraft(value);
      save.mutate(value);
    },
  });

  return {
    draft, ready, generate, save,
    busy: generate.isPending || save.isPending,
    discard: () => { setDraft(undefined); save.reset(); },
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
