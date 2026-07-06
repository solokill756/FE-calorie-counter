import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/dialogs/app_dialogs.dart';
import '../../../../app/app_router.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../data/onboarding_payload_mapper.dart';
import '../../application/cubit/auth_cubit.dart';

class Step10Congratulations extends StatefulWidget {
  final UserProfileModel userProfile;
  final VoidCallback? onBack;

  const Step10Congratulations({
    super.key,
    required this.userProfile,
    this.onBack,
  });

  @override
  State<Step10Congratulations> createState() => _Step10CongratulationsState();
}

class _Step10CongratulationsState extends State<Step10Congratulations> {
  bool _isSaving = false;
  bool _nutritionLoading = true;
  int _previewCalories = 0;

  @override
  void initState() {
    super.initState();
    _loadNutritionPreview();
  }

  Future<void> _loadNutritionPreview() async {
    final result = await context.read<AuthCubit>().previewNutrition(
          userProfile: widget.userProfile,
        );
    if (!mounted) return;
    result.fold(
      (data) {
        setState(() {
          _previewCalories = (data['targetCalories'] as num?)?.round() ?? 0;
          _nutritionLoading = false;
        });
      },
      (_) {
        setState(() {
          _previewCalories = 0;
          _nutritionLoading = false;
        });
      },
    );
  }

  String _goalType() => OnboardingPayloadMapper.goalsToGoalType(
    widget.userProfile.goals,
  );

  String _goalProgressSummary() {
    final goalType = _goalType();
    final currentWeight = widget.userProfile.currentWeightKg;
    final goalWeight = widget.userProfile.goalWeightKg;
    final weightDelta = (goalWeight - currentWeight).abs();

    if (goalType == 'muscle_gain') return 'Gain muscle';
    if (goalType == 'maintenance') return 'Maintain current weight';
    if (goalType == 'modify_diet') return 'Improve your diet';
    if (goalType == 'plan_meals') return 'Plan meals consistently';
    if (goalType == 'manage_stress') return 'Manage stress';
    if (goalType == 'stay_active') return 'Stay active';

    if (goalType == 'weight_gain') {
      if (goalWeight <= currentWeight || weightDelta <= 0) return 'Gain weight';
      return _formatWeightGoal('Gain', weightDelta);
    }

    if (goalType == 'weight_loss') {
      if (goalWeight >= currentWeight || weightDelta <= 0) {
        return 'Maintain current weight';
      }
      return _formatWeightGoal('Lose', weightDelta);
    }

    return 'Maintain current weight';
  }

  String _formatWeightGoal(String action, double weightDelta) {
    return '$action ${weightDelta.toStringAsFixed(0)} kg';
  }

  String _goalSupportCopy() {
    final goalType = _goalType();
    if (goalType == 'weight_loss') return 'This can help you lose:';
    if (goalType == 'weight_gain') return 'This can help you gain:';
    return 'This can support:';
  }

  @override
  Widget build(BuildContext context) {
    final dailyCalories = _nutritionLoading
        ? 0
        : (_previewCalories > 0
              ? _previewCalories
              : widget.userProfile.dailyCalorieTarget);
    final goalSummary = _goalProgressSummary();
    final goalSupportCopy = _goalSupportCopy();
    final userName = widget.userProfile.displayName ?? 'there';

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            saveProfileSuccess: (message) {
              context.hideLoadingDialog();
              AppDialogs.showSuccessSnackBar(message: message);
              try {
                context.router.pushAndPopUntil(
                  MainNavigationRoute(),
                  predicate: (route) => false,
                );
              } catch (e) {
                // Fallback navigation
                print('Error during navigation: $e');
                Navigator.of(context).pushReplacementNamed('/main-navigation');
              }
            },
            error: (message) {
              context.hideLoadingDialog();
              AppDialogs.showErrorSnackBar(message: message);
            },
            orElse: () {},
          );
        },
        child: SafeArea(
          child: Column(
            children: [
              // Content area - scrollable if needed
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),

                      // Compact icon with celebration animation
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 800),
                        curve: Curves.elasticOut,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              width: 64.w,
                              height: 64.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF4CAF50),
                                    Color(0xFF66BB6A),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(18.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF4CAF50).withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.celebration_outlined,
                                color: Colors.white,
                                size: 32.sp,
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 24.h),

                      // Title with animation
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 600),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          'Congratulations, $userName!',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Subtitle with animation
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 600),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          'Your nutrition plan is ready and you\'re one step closer to your goal weight.',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Calorie goal card with animation
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: 0.8 + (0.2 * value),
                            child: Opacity(opacity: value, child: child),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(24.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF4CAF50).withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Your daily net calorie goal is:',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _nutritionLoading
                                      ? SizedBox(
                                          width: 36.w,
                                          height: 36.w,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          dailyCalories > 0
                                              ? dailyCalories.toString()
                                              : '—',
                                          style: TextStyle(
                                            fontSize: 40.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                  SizedBox(width: 12.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Text(
                                      'Calories',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                '$goalSupportCopy $goalSummary',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),

              // Fixed bottom button
              Container(
                padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    state.maybeWhen(
                      savingProfileLoading: () => _isSaving = true,
                      orElse: () => _isSaving = false,
                    );
                    return LoadingButton(
                      isLoading: _isSaving,
                      backgroundColor: Color(0xFF4CAF50),
                      textColor: Colors.white,
                      onPressed: () async {
                        await context.read<AuthCubit>().submitOnboarding(
                          userProfile: widget.userProfile,
                        );
                      },
                      text: 'Get Started',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
