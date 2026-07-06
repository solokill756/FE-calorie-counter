import 'package:caloriecounter/src/modules/auth/data/models/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/navigation_buttons.dart';

class Step5MealPlanning extends StatefulWidget {
  final UserProfileModel userProfile;
  final Function(UserProfileModel) onNext;
  final VoidCallback? onBack;

  const Step5MealPlanning({
    super.key,
    required this.userProfile,
    required this.onNext,
    this.onBack,
  });

  @override
  State<Step5MealPlanning> createState() => _Step5MealPlanningState();
}

class _Step5MealPlanningState extends State<Step5MealPlanning> {
  String _selectedFrequency = '';

  final List<Map<String, String>> _frequencies = [
    {'label': 'Never', 'value': 'never'},
    {'label': 'Rarely', 'value': 'rarely'},
    {'label': 'Occasionally', 'value': 'occasionally'},
    {'label': 'Frequently', 'value': 'frequently'},
    {'label': 'Always', 'value': 'always'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedFrequency = widget.userProfile.mealPlanningFrequency.isNotEmpty
        ? widget.userProfile.mealPlanningFrequency
        : '';
  }

  void _handleNext() {
    if (_selectedFrequency.isNotEmpty) {
      widget.onNext(
        widget.userProfile.copyWith(mealPlanningFrequency: _selectedFrequency),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasSelection = _selectedFrequency.isNotEmpty;

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
                              Icons.restaurant_menu_outlined,
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
                        'How often do you plan your meals in advance?',
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
                        'Planning helps you stay on track with your goals.',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Frequency selection list
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _frequencies.length,
                      itemBuilder: (context, index) {
                        final frequency = _frequencies[index]['label']!;
                        final value = _frequencies[index]['value']!;
                        final isSelected =
                            _selectedFrequency == _frequencies[index]['value'];

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
                                onTap: () {
                                  setState(() {
                                    _selectedFrequency = value;
                                  });
                                },
                                borderRadius: BorderRadius.circular(16.r),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 16.h,
                                  ),
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
                                        child: Text(
                                          frequency,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                            color: isSelected
                                                ? Color(0xFF1E88E5)
                                                : Colors.black87,
                                          ),
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
                          'Planning frequency: $_selectedFrequency',
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
