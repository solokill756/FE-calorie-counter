import { useState } from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import { Action, Card, colors, Field } from '../../components/ui';
import {
  foodFilterNutrients, parseNutrientFilterDraft, toNutrientFilterDraft,
  type FoodFilterNutrient, type FoodNutrientFilters,
} from './nutrient-filters';

export function NutrientFilterForm({ filters, onApply, onClose }: {
  filters?: FoodNutrientFilters;
  onApply(filters: FoodNutrientFilters): void;
  onClose(): void;
}) {
  const [selected, setSelected] = useState<(typeof foodFilterNutrients)[number]>(foodFilterNutrients[0]);
  const [draft, setDraft] = useState(() => toNutrientFilterDraft(filters));
  const parsed = parseNutrientFilterDraft(draft);

  function updateBound(key: FoodFilterNutrient, bound: 'min' | 'max', value: string) {
    setDraft((previous) => ({ ...previous, [key]: { ...previous[key], [bound]: value } }));
  }

  return <Card>
    <Text style={styles.hint}>Amounts per serving. Leave either limit blank to skip it.</Text>
    <View style={styles.nutrients}>
      {foodFilterNutrients.map((nutrient) => {
        const active = nutrient.key === selected.key;
        const hasBounds = Boolean(draft[nutrient.key]?.min?.trim() || draft[nutrient.key]?.max?.trim());
        return <Pressable key={nutrient.key} accessibilityRole="button" accessibilityState={{ selected: active }}
          accessibilityLabel={nutrient.label} style={[styles.option, active && styles.selected]}
          onPress={() => setSelected(nutrient)}>
          <Text style={active ? styles.selectedText : styles.optionText}>{nutrient.label}{hasBounds ? ' ✓' : ''}</Text>
        </Pressable>;
      })}
    </View>
    <Field label={`Minimum ${selected.label} (${selected.unit})`} keyboardType="decimal-pad"
      value={draft[selected.key]?.min ?? ''} onChangeText={(value) => updateBound(selected.key, 'min', value)} />
    <Field label={`Maximum ${selected.label} (${selected.unit})`} keyboardType="decimal-pad"
      value={draft[selected.key]?.max ?? ''} onChangeText={(value) => updateBound(selected.key, 'max', value)} />
    {parsed.error && <Text accessibilityLiveRegion="polite" style={styles.error}>{parsed.error}</Text>}
    <Action title="Apply filters" disabled={!parsed.filters} onPress={() => { if (parsed.filters) onApply(parsed.filters); }} />
    <Action title="Clear filters" onPress={() => onApply({})} />
    <Action title="Cancel" onPress={onClose} />
  </Card>;
}

const styles = StyleSheet.create({
  hint: { color: colors.muted },
  nutrients: { flexDirection: 'row', flexWrap: 'wrap', gap: 8 },
  option: { minHeight: 44, justifyContent: 'center', paddingHorizontal: 12, borderRadius: 22,
    borderWidth: 1, borderColor: colors.line },
  selected: { backgroundColor: colors.action, borderColor: colors.action },
  optionText: { color: colors.ink },
  selectedText: { color: colors.surface },
  error: { color: colors.error },
});
