import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/user_profile_model.dart';
import '../common/navigation_buttons.dart';

class Step2Goals extends StatefulWidget {
  final UserProfileModel userProfile;
  final Function(UserProfileModel) onNext;
  final VoidCallback? onBack;

  const Step2Goals({
    super.key,
    required this.userProfile,
    required this.onNext,
    this.onBack,
  });

  @override
  State<Step2Goals> createState() => _Step2GoalsState();
}

class _Step2GoalsState extends State<Step2Goals> {
  List<String> _selectedGoals = [];

  final List<String> _availableGoals = [
    'Lose Weight',
    'Maintain Weight',
    'Gain Weight',
    'Gain Muscle',
    'Modify My Diet',
    'Plan Meals',
    'Manage Stress',
    'Stay Active',
  ];

  @override
  void initState() {
    super.initState();
    final fromProfile = List<String>.from(widget.userProfile.goals);
    _selectedGoals = fromProfile.isEmpty ? [] : [fromProfile.first];
  }

  void _toggleGoal(String goal) {
    setState(() {
      if (_selectedGoals.length == 1 && _selectedGoals.first == goal) {
        _selectedGoals = [];
        return;
      }
      _selectedGoals = [goal];
    });
  }

  void _handleNext() {
    if (_selectedGoals.isNotEmpty) {
      widget.onNext(
        widget.userProfile.copyWith(goals: _selectedGoals),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = widget.userProfile.displayName ?? 'there';
    final canContinue = _selectedGoals.isNotEmpty;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutBack,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(14.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF1E88E5,
                                  ).withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.flag_outlined,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 500),
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
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                          children: [
                            TextSpan(text: 'Hey, $userName. '),
                            TextSpan(
                              text: '👋',
                              style: TextStyle(fontSize: 28.sp),
                            ),
                            const TextSpan(
                              text: ' Let\'s start with your goal.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 500),
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
                        'Choose one primary goal.',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _availableGoals.length,
                      itemBuilder: (context, index) {
                        final goal = _availableGoals[index];
                        final isSelected = _selectedGoals.contains(goal);

                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(milliseconds: 300 + (index * 50)),
                          curve: Curves.easeOut,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(30 * (1 - value), 0),
                              child: Opacity(opacity: value, child: child),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            child: Material(
                              borderRadius: BorderRadius.circular(16.r),
                              child: InkWell(
                                onTap: () => _toggleGoal(goal),
                                borderRadius: BorderRadius.circular(16.r),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 16.h,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF1E88E5)
                                          : Colors.grey[200]!,
                                      width: isSelected ? 2 : 1,
                                    ),
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: isSelected
                                        ? const Color(
                                            0xFF1E88E5,
                                          ).withOpacity(0.05)
                                        : Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          goal,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                            color: isSelected
                                                ? const Color(0xFF1E88E5)
                                                : Colors.black87,
                                          ),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        width: 24.w,
                                        height: 24.h,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? const Color(0xFF1E88E5)
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: isSelected
                                                ? const Color(0xFF1E88E5)
                                                : Colors.grey[400]!,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            6.r,
                                          ),
                                        ),
                                        child: isSelected
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 16.sp,
                                              )
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: NavigationButtons(
                onNext: canContinue ? _handleNext : null,
                onBack: widget.onBack,
                isNextEnabled: canContinue,
                showBackButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
