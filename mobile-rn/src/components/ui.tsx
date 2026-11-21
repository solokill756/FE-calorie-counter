import type { PropsWithChildren } from 'react';
import { ActivityIndicator, Pressable, ScrollView, StyleSheet, Text, TextInput, type TextInputProps, View } from 'react-native';

export const colors = {
  ink: '#15262c',
  muted: '#54676e',
  action: '#046965',
  surface: '#ffffff',
  background: '#f0f6f4',
  line: '#cadbd7',
  error: '#982628',
};

export function Screen({ children, title }: PropsWithChildren<{ title: string }>) {
  return (
    <ScrollView contentContainerStyle={styles.screen} keyboardShouldPersistTaps="handled">
      <Text accessibilityRole="header" style={styles.heading}>{title}</Text>
      {children}
    </ScrollView>
  );
}

export function Card({ children }: PropsWithChildren) {
  return <View style={styles.card}>{children}</View>;
}

export function Body({ children }: PropsWithChildren) {
  return <Text style={styles.body}>{children}</Text>;
}

export function Action({ title, onPress, disabled }: {
  title: string;
  onPress(): void;
  disabled?: boolean;
}) {
  return (
    <Pressable accessibilityRole="button" disabled={disabled} onPress={onPress}
      style={({ pressed }) => [styles.action, (pressed || disabled) && styles.dimmed]}>
      <Text style={styles.actionText}>{title}</Text>
    </Pressable>
  );
}

export function Field({ label, ...props }: TextInputProps & { label: string }) {
  return (
    <View style={styles.field}>
      <Text style={styles.body}>{label}</Text>
      <TextInput accessibilityLabel={label} placeholderTextColor={colors.muted} style={styles.input} {...props} />
    </View>
  );
}

export function Message({ error, retry }: { error: unknown; retry?: () => void }) {
  if (!error) return null;
  return (
    <View style={styles.field}>
      <Text accessibilityRole="alert" style={styles.error}>
        {error instanceof Error ? error.message : String(error)}
      </Text>
      {retry && <Action title="Try again" onPress={retry} />}
    </View>
  );
}

export function Loading() {
  return (
    <View style={styles.loading}>
      <ActivityIndicator accessibilityLabel="Loading" color={colors.action} />
    </View>
  );
}

const styles = StyleSheet.create({
  screen: { padding: 20, gap: 16, flexGrow: 1, backgroundColor: colors.background },
  heading: { color: colors.ink, fontSize: 32, fontWeight: '700', marginBottom: 4 },
  body: { color: colors.ink, fontSize: 16, lineHeight: 23 },
  card: { gap: 10, padding: 16, backgroundColor: colors.surface, borderRadius: 16, borderColor: colors.line, borderWidth: 1 },
  field: { gap: 6 },
  input: { minHeight: 48, paddingHorizontal: 12, color: colors.ink, backgroundColor: colors.surface, borderRadius: 9, borderColor: colors.line, borderWidth: 1 },
  action: { minHeight: 46, paddingHorizontal: 12, paddingVertical: 10, backgroundColor: colors.action, justifyContent: 'center', alignItems: 'center', borderRadius: 9 },
  dimmed: { opacity: 0.65 },
  actionText: { color: '#ffffff', fontSize: 15, fontWeight: '600', textAlign: 'center' },
  error: { color: colors.error, fontSize: 15 },
  loading: { padding: 24, alignItems: 'center' },
});
