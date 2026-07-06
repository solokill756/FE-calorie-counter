import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';
import 'package:caloriecounter/src/modules/app/app_router.dart';
import 'package:caloriecounter/src/modules/auth/data/models/user_profile_model.dart';
import 'package:caloriecounter/src/modules/auth/data/models/user_nutritional_threshold_model.dart';
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/user_profile_cubit.dart';
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/user_profile_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

@RoutePage()
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserProfileCubit>().refresh(showLoading: true);
  }

  Future<void> _openEditProfile() async {
    await context.router.push(const EditProfileRoute());
    if (mounted) {
      await context.read<UserProfileCubit>().refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        final profile = state.maybeWhen(
          loaded: (p) => p,
          loading: (previous) => previous,
          error: (_, previous) => previous,
          orElse: () => null,
        );

        if (profile == null &&
            state.maybeWhen(loading: (_) => true, orElse: () => false)) {
          return Scaffold(
            backgroundColor: scheme.surfaceContainerLowest,
            appBar: AppShellUi.appBar(context, 'Profile'),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (profile == null) {
          return Scaffold(
            backgroundColor: scheme.surfaceContainerLowest,
            appBar: AppShellUi.appBar(context, 'Profile'),
            body: const _EmptyProfileView(),
          );
        }

        return _ProfileContent(profile: profile, onEdit: _openEditProfile);
      },
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.profile, required this.onEdit});

  final UserProfileModel profile;
  final Future<void> Function() onEdit;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      appBar: AppShellUi.appBar(
        context,
        'Profile',
        actions: [TextButton(onPressed: onEdit, child: const Text('Edit'))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          _ProfileHeader(profile: profile),
          const Gap(14),
          _ProfileSection(
            title: 'Basic info',
            icon: Icons.badge_outlined,
            rows: [
              _ProfileRow('Gender', _text(profile.gender)),
              _ProfileRow('Age', _positiveInt(profile.age, suffix: 'years')),
            ],
          ),
          _ProfileSection(
            title: 'Goals',
            icon: Icons.flag_outlined,
            rows: [
              _ProfileRow('Primary goal', _list(profile.goals)),
              _ProfileRow(
                'Starting weight',
                _positiveDouble(profile.currentWeightKg, suffix: 'kg'),
              ),
              _ProfileRow(
                'Goal weight',
                _positiveDouble(profile.goalWeightKg, suffix: 'kg'),
              ),
            ],
          ),
          _ProfileSection(
            title: 'Body metrics',
            icon: Icons.monitor_weight_outlined,
            rows: [
              _ProfileRow(
                'Height',
                _positiveDouble(profile.heightCm, suffix: 'cm'),
              ),
              _ProfileRow(
                'Current weight',
                _positiveDouble(profile.currentWeightKg, suffix: 'kg'),
              ),
              _ProfileRow('BMI', _bmi(profile)),
            ],
          ),
          _ProfileSection(
            title: 'Lifestyle',
            icon: Icons.directions_run_outlined,
            rows: [
              _ProfileRow(
                'Activity level',
                _activityLevel(profile.activityLevel),
              ),
              _ProfileRow(
                'Meal planning',
                _titleCase(profile.mealPlanningFrequency),
              ),
            ],
          ),
          _ProfileSection(
            title: 'Health context',
            icon: Icons.health_and_safety_outlined,
            rows: [
              _ProfileRow('Allergies', _list(profile.barriers)),
              _ProfileRow(
                'Medical conditions',
                _conditions(profile.conditionTypes),
              ),
            ],
          ),
          _ProfileSection(
            title: 'Nutrition targets',
            icon: Icons.local_fire_department_outlined,
            rows: [
              _ProfileRow(
                'Daily calories',
                _positiveInt(profile.dailyCalorieTarget, suffix: 'kcal'),
              ),
              _ProfileRow(
                'Carbs',
                _macro(profile.macroCarbsG, profile.computedCarbsPercent),
              ),
              _ProfileRow(
                'Protein',
                _macro(profile.macroProteinG, profile.computedProteinPercent),
              ),
              _ProfileRow(
                'Fat',
                _macro(profile.macroFatG, profile.computedFatPercent),
              ),
              _ProfileRow(
                'Nutrient limits',
                _thresholds(profile.nutritionalThresholds),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profile});

  final UserProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final name = _text(profile.displayName);
    final email = _text(profile.email);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: scheme.primaryContainer,
            backgroundImage:
                profile.avatarUrl != null &&
                    profile.avatarUrl!.trim().isNotEmpty
                ? CachedNetworkImageProvider(profile.avatarUrl!)
                : null,
            child: profile.avatarUrl == null || profile.avatarUrl!.isEmpty
                ? Icon(Icons.person, color: scheme.onPrimaryContainer, size: 32)
                : null,
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
                if (email != _notProvided) ...[
                  const Gap(4),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 14,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({
    required this.title,
    required this.icon,
    required this.rows,
  });

  final String title;
  final IconData icon;
  final List<_ProfileRow> rows;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: scheme.primary),
                const Gap(8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
            const Gap(10),
            ...rows,
          ],
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyProfileView extends StatelessWidget {
  const _EmptyProfileView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No profile data yet. Complete onboarding or pull to refresh.',
      ),
    );
  }
}

const _notProvided = 'Not provided';

String _text(String? value) {
  final trimmed = value?.trim() ?? '';
  return trimmed.isEmpty ? _notProvided : trimmed;
}

String _list(List<String> values) {
  final normalized = values.map(_text).where((v) => v != _notProvided).toList();
  return normalized.isEmpty ? _notProvided : normalized.join(', ');
}

String _bmi(UserProfileModel profile) {
  final bmi = profile.bmi;
  if (bmi <= 0) return _notProvided;
  return '${bmi.toStringAsFixed(1)} (${profile.bmiCategory})';
}

String _positiveInt(int value, {String suffix = ''}) {
  if (value <= 0) return _notProvided;
  return suffix.isEmpty ? '$value' : '$value $suffix';
}

String _positiveDouble(double value, {String suffix = ''}) {
  if (value <= 0) return _notProvided;
  final text = value == value.roundToDouble()
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(1);
  return suffix.isEmpty ? text : '$text $suffix';
}

String _macro(double grams, double percent) {
  if (grams <= 0 && percent <= 0) return _notProvided;
  if (grams > 0 && percent > 0) {
    return '${_formatAmount(grams)} g (${_formatAmount(percent)}%)';
  }
  if (grams > 0) return '${_formatAmount(grams)} g';
  return '${_formatAmount(percent)}%';
}

String _activityLevel(String value) {
  switch (value.trim().toLowerCase()) {
    case 'sedentary':
      return 'Sedentary';
    case 'lightly_active':
      return 'Lightly active';
    case 'moderately_active':
      return 'Moderately active';
    case 'very_active':
      return 'Very active';
    case 'extra_active':
      return 'Extra active';
    default:
      return _titleCase(value);
  }
}

String _conditions(List<String> types) {
  if (types.isEmpty) return _notProvided;
  return types.map((type) => _conditionLabel(type)).join(', ');
}

String _conditionLabel(String key) {
  switch (key.trim().toLowerCase()) {
    case 'diabetes':
      return 'Diabetes';
    case 'pre-diabetes':
      return 'Pre-diabetes';
    case 'hypertension':
      return 'Hypertension';
    case 'heart_disease':
      return 'Heart disease';
    case 'kidney_disease':
      return 'Kidney disease';
    case 'celiac':
      return 'Celiac disease';
    default:
      return _titleCase(key);
  }
}

String _titleCase(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return _notProvided;
  return trimmed
      .split(RegExp(r'[\s_]+'))
      .where((part) => part.isNotEmpty)
      .map((part) => part[0].toUpperCase() + part.substring(1).toLowerCase())
      .join(' ');
}

String _thresholds(List<UserNutritionalThreshold> values) {
  if (values.isEmpty) return _notProvided;
  return values
      .map((item) {
        final nutrient = _titleCase('${item.nutrient}');
        final min = item.minAmount;
        final max = item.maxAmount;
        final unit = '${item.unit}'.trim().isEmpty ? 'g' : '${item.unit}';
        if (min != null && max != null) {
          return '$nutrient ${_formatAmount(min)}-${_formatAmount(max)} $unit';
        }
        if (min != null) return '$nutrient >= ${_formatAmount(min)} $unit';
        if (max != null) return '$nutrient <= ${_formatAmount(max)} $unit';
        return '$nutrient $unit';
      })
      .join(', ');
}

String _formatAmount(num value) {
  final doubleValue = value.toDouble();
  return doubleValue == doubleValue.roundToDouble()
      ? doubleValue.toStringAsFixed(0)
      : doubleValue.toStringAsFixed(1);
}
