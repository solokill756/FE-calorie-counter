import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/widgets/loading_widget.dart';
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/dialogs/app_dialogs.dart';
import '../../../app/app_router.dart';
import '../../data/models/user_profile_model.dart';
import '../widgets/signup_steps/step_1_name.dart';
import '../widgets/signup_steps/step_2_goals.dart';
import '../widgets/signup_steps/step_3_barriers.dart';
import '../widgets/signup_steps/step_4_medical.dart';
import '../widgets/signup_steps/step_5_meal_planning.dart';
import '../widgets/signup_steps/step_6_activity_level.dart';
import '../widgets/signup_steps/step_7_personal_info.dart';
import '../widgets/signup_steps/step_8_measurements.dart';
import '../widgets/signup_steps/step_10_congratulations.dart';

@RoutePage()
class SignUpFlowPage extends StatefulWidget {
  const SignUpFlowPage({super.key});

  @override
  State<SignUpFlowPage> createState() => _SignUpFlowPageState();
}

class _SignUpFlowPageState extends State<SignUpFlowPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 9;
  bool _isNavigating = false;

  UserProfileModel _userProfile = const UserProfileModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final merged = await context.read<AuthCubit>().loadOnboardingDraft(
        _userProfile,
      );
      if (mounted) {
        setState(() => _userProfile = merged);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() async {
    if (_isNavigating || _currentStep >= _totalSteps - 1) return;

    setState(() {
      _isNavigating = true;
    });

    try {
      setState(() {
        _currentStep++;
      });

      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isNavigating = false;
        });
      }
    }
  }

  void _previousStep() async {
    if (_isNavigating || _currentStep <= 0) return;

    setState(() {
      _isNavigating = true;
    });

    try {
      setState(() {
        _currentStep--;
      });

      await _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isNavigating = false;
        });
      }
    }
  }

  void _updateProfile(UserProfileModel newProfile) {
    setState(() {
      _userProfile = newProfile;
    });
  }

  Future<void> _showLogoutConfirmation() async {
    final colorScheme = Theme.of(context).colorScheme;
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Log out?'),
          content: const Text(
            'Your onboarding progress saved on the server will stay available when you log back in.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton.icon(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
              ),
              icon: const Icon(Icons.logout_rounded, size: 18),
              label: const Text('Log out'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true && mounted) {
      await context.read<AuthCubit>().logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _currentStep > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: _isNavigating
                    ? null
                    : (_currentStep > 0 ? _previousStep : () {}),
              )
            : null,
        title: Text(
          _getStepTitle(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout_rounded),
            color: Theme.of(context).colorScheme.error,
            onPressed: _isNavigating ? null : _showLogoutConfirmation,
          ),
        ],
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            unauthenticated: (message) {
              context.hideLoadingDialog();
              Future.delayed(const Duration(milliseconds: 300), () async {
                AppDialogs.showSnackBar(
                  message: message,
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                );
                try {
                  if (context.mounted) {
                    await context.router.replaceAll([const WelcomeRoute()]);
                  }
                } catch (e) {
                  if (context.mounted) {
                    await Navigator.of(
                      context,
                    ).pushReplacementNamed('/welcome');
                  }
                }
              });
            },
            error: (message) {
              context.hideLoadingDialog();
              // Show error message
              Future.delayed(const Duration(milliseconds: 300), () async {
                AppDialogs.showSnackBar(
                  message: message,
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                );
              });
            },
            loading: () {
              context.showLoadingDialog(
                message: 'Log Out...',
                type: LoadingType.circular,
              );
            },
            orElse: () {},
          );
        },
        child: SafeArea(
          child: Column(
            children: [
              // Progress Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: LinearProgressIndicator(
                  value: (_currentStep + 1) / _totalSteps,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                  minHeight: 4.h,
                ),
              ),

              // Content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    // Sync currentStep if user somehow navigates programmatically
                    if (_currentStep != index) {
                      setState(() {
                        _currentStep = index;
                      });
                    }
                  },
                  children: [
                    Step1Name(
                      key: ValueKey('step_1'),
                      userProfile: _userProfile,
                      onNext: (UserProfileModel profile) {
                        _updateProfile(profile);
                        _nextStep();
                      },
                      onBack: () {},
                    ),
                    Step2Goals(
                      key: ValueKey('step_2'),
                      userProfile: _userProfile,
                      onNext: (UserProfileModel profile) {
                        _updateProfile(profile);
                        _nextStep();
                      },
                      onBack: _previousStep,
                    ),
                    Step3Barriers(
                      key: ValueKey('step_3'),
                      userProfile: _userProfile,
                      onNext: (UserProfileModel profile) {
                        _updateProfile(profile);
                        _nextStep();
                      },
                      onBack: _previousStep,
                    ),
                    Step4Medical(
                      key: ValueKey('step_4'),
                      userProfile: _userProfile,
                      onNext: (UserProfileModel profile) {
                        _updateProfile(profile);
                        _nextStep();
                      },
                      onBack: _previousStep,
                    ),
                    Step5MealPlanning(
                      key: ValueKey('step_5'),
                      userProfile: _userProfile,
                      onNext: (UserProfileModel profile) {
                        _updateProfile(profile);
                        _nextStep();
                      },
                      onBack: _previousStep,
                    ),
                    Step6ActivityLevel(
                      key: ValueKey('step_6'),
                      userProfile: _userProfile,
                      onNext: (UserProfileModel profile) {
                        _updateProfile(profile);
                        _nextStep();
                      },
                      onBack: _previousStep,
                    ),
                    Step7PersonalInfo(
                      key: ValueKey('step_7'),
                      userProfile: _userProfile,
                      onNext: (UserProfileModel profile) {
                        _updateProfile(profile);
                        _nextStep();
                      },
                      onBack: _previousStep,
                    ),
                    Step8Measurements(
                      key: ValueKey('step_8'),
                      userProfile: _userProfile,
                      onNext: (UserProfileModel profile) {
                        _updateProfile(profile);
                        _nextStep();
                      },
                      onBack: _previousStep,
                    ),

                    Step10Congratulations(
                      key: ValueKey('step_10'),
                      userProfile: _userProfile,
                      onBack: _previousStep,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Welcome';
      case 1:
      case 2:
      case 4:
      case 5:
        return 'Goals';
      case 3:
        return 'Health';
      case 6:
      case 7:
        return 'You';
      case 8:
        return 'Create Account';
      default:
        return 'Welcome';
    }
  }
}
