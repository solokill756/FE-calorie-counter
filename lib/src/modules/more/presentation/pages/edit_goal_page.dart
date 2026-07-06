import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/user_profile_access.dart';
import 'package:caloriecounter/src/modules/auth/data/onboarding_payload_mapper.dart';
import 'package:caloriecounter/src/modules/auth/domain/repository/auth_repository.dart';
import 'package:caloriecounter/src/modules/more/presentation/application/goal_saved_refresh.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

@RoutePage()
class EditGoalPage extends StatefulWidget {
  const EditGoalPage({super.key});

  @override
  State<EditGoalPage> createState() => _EditGoalPageState();
}

class _EditGoalPageState extends State<EditGoalPage> {
  final _authRepository = getIt<AuthRepository>();
  static const _labels = [
    'Lose Weight',
    'Maintain Weight',
    'Gain Weight',
    'Gain Muscle',
    'Modify My Diet',
    'Plan Meals',
    'Manage Stress',
    'Stay Active',
  ];

  String? _selectedLabel;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final p = readServerProfile();
    if (p != null && p.goals.isNotEmpty) {
      _selectedLabel = p.goals.first;
    }
  }

  Future<void> _save() async {
    final label = _selectedLabel;
    if (label == null) {
      AppDialogs.showWarningSnackBar(message: 'Please select a goal');
      return;
    }
    setState(() => _saving = true);
    final slug = OnboardingPayloadMapper.goalsToGoalType([label]);
    final result = await _authRepository.patchUserGoal(goalTypeSlug: slug);
    if (!mounted) return;
    setState(() => _saving = false);

    if (result.isError()) {
      final err = result.exceptionOrNull()!;
      AppDialogs.showErrorSnackBar(
        message: err.message.isNotEmpty ? err.message : 'Could not update goal',
      );
      return;
    }

    await refreshGoalDependentData();
    AppDialogs.showSuccessSnackBar(message: 'Goal updated');
    if (mounted) context.router.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Your goal',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    'Save',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          Text(
            'Choose your primary goal. Daily calorie and macro targets are recalculated when you save.',
            style: TextStyle(
              fontSize: 14,
              height: 1.45,
              color: Colors.grey[800],
            ),
          ),
          const Gap(20),
          Text('Primary goal', style: Theme.of(context).textTheme.titleSmall),
          const Gap(8),
          ..._labels.map((g) {
            final selected = _selectedLabel == g;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => setState(() => _selectedLabel = g),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFF1E88E5)
                            : Colors.grey.shade300,
                        width: selected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            g,
                            style: TextStyle(
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: selected
                                  ? const Color(0xFF1E88E5)
                                  : Colors.black87,
                            ),
                          ),
                        ),
                        if (selected)
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF1E88E5),
                            size: 22,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
