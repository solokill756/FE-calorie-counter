import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/user_profile_model.dart';
import '../common/navigation_buttons.dart';

class Step6ActivityLevel extends StatefulWidget {
  final UserProfileModel userProfile;
  final Function(UserProfileModel) onNext;
  final VoidCallback? onBack;

  const Step6ActivityLevel({
    super.key,
    required this.userProfile,
    required this.onNext,
    this.onBack,
  });

  @override
  State<Step6ActivityLevel> createState() => _Step6ActivityLevelState();
}

class _Step6ActivityLevelState extends State<Step6ActivityLevel> {
  String _selectedActivityLevel = '';

  final List<Map<String, String>> _activityLevels = [
    {
      'level': 'Extremely Active',
      'description':
          'Spend a good part of the day doing heavy physical activity (e.g. bike messenger, carpenter)',
      'value': 'extra',
    },
    {
      'level': 'Lightly Active',
      'description':
          'Spend a good part of the day on your feet (e.g. teacher, salesperson)',
      'value': 'lightly',
    },
    {
      'level': 'moderately Active',
      'description':
          'Spend a good part of the day doing some physical activity (e.g. food server, postal carrier)',
      'value': 'moderately',
    },
    {
      'level': 'Very Active',
      'description':
          'Spend most of the day doing heavy physical activity (e.g. bike messenger, carpenter)',
      'value': 'very',
    },
    {
      'level': 'Sedentary Active',
      'description': 'Little or no exercise, desk job',
      'value': 'sedentary',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedActivityLevel = widget.userProfile.activityLevel;
  }

  void _handleNext() {
    if (_selectedActivityLevel.isNotEmpty) {
      widget.onNext(
        widget.userProfile.copyWith(activityLevel: _selectedActivityLevel),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasSelection = _selectedActivityLevel.isNotEmpty;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Content area - scrollable if needed
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),

                    // Compact icon
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeOutBack,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(14.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF1E88E5).withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.directions_run_outlined,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    // Title with animation
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 500),
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
                        'What is your baseline activity level?',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.2,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Subtitle with animation
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 500),
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
                        'Not including workouts - we count that separately.',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Activity level selection list
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _activityLevels.length,
                      itemBuilder: (context, index) {
                        final activity = _activityLevels[index];
                        final isSelected =
                            _selectedActivityLevel == activity['value'];

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
                            margin: EdgeInsets.only(bottom: 16.h),
                            child: Material(
                              borderRadius: BorderRadius.circular(16.r),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedActivityLevel = activity['value']!;
                                  });
                                },
                                borderRadius: BorderRadius.circular(16.r),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  padding: EdgeInsets.all(20.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected
                                          ? Color(0xFF1E88E5)
                                          : Colors.grey[200]!,
                                      width: isSelected ? 2 : 1,
                                    ),
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: isSelected
                                        ? Color(0xFF1E88E5).withOpacity(0.05)
                                        : Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              activity['level']!,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color: isSelected
                                                    ? Color(0xFF1E88E5)
                                                    : Colors.black87,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              activity['description']!,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.grey[600],
                                                height: 1.3,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        width: 24.w,
                                        height: 24.h,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Color(0xFF1E88E5)
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: isSelected
                                                ? Color(0xFF1E88E5)
                                                : Colors.grey[400]!,
                                          ),
                                          shape: BoxShape.circle,
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

                    // Selection indicator
                    if (hasSelection) ...[
                      SizedBox(height: 16.h),
                      AnimatedOpacity(
                        opacity: hasSelection ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 200),
                        child: Text(
                          'Activity level: $_selectedActivityLevel',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xFF1E88E5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Fixed navigation buttons at bottom
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
              child: NavigationButtons(
                onNext: hasSelection ? _handleNext : null,
                onBack: widget.onBack,
                isNextEnabled: hasSelection,
                showBackButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
