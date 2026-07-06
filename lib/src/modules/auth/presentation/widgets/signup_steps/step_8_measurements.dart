import 'package:caloriecounter/src/common/widgets/hide_keyboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/user_profile_model.dart';
import '../common/navigation_buttons.dart';

class Step8Measurements extends StatefulWidget {
  final UserProfileModel userProfile;
  final Function(UserProfileModel) onNext;
  final VoidCallback? onBack;

  const Step8Measurements({
    super.key,
    required this.userProfile,
    required this.onNext,
    this.onBack,
  });

  @override
  State<Step8Measurements> createState() => _Step8MeasurementsState();
}

class _Step8MeasurementsState extends State<Step8Measurements> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _goalWeightController = TextEditingController();
  final FocusNode _focusHeightNode = FocusNode();
  final FocusNode _focusWeightNode = FocusNode();
  final FocusNode _focusGoalWeightNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _heightController.text = widget.userProfile.heightCm > 0
        ? widget.userProfile.heightCm.toString()
        : '';
    _weightController.text = widget.userProfile.currentWeightKg > 0
        ? widget.userProfile.currentWeightKg.toString()
        : '';
    _goalWeightController.text = widget.userProfile.goalWeightKg > 0
        ? widget.userProfile.goalWeightKg.toString()
        : '';
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _goalWeightController.dispose();
    _focusHeightNode.dispose();
    _focusWeightNode.dispose();
    _focusGoalWeightNode.dispose();
    super.dispose();
  }

  void _handleNext() {
    final height = double.tryParse(_heightController.text) ?? 0;
    final weight = double.tryParse(_weightController.text) ?? 0;
    final goalWeight = double.tryParse(_goalWeightController.text) ?? 0;

    if (height > 0 && weight > 0 && goalWeight > 0) {
      widget.onNext(
        widget.userProfile.copyWith(
          heightCm: height,
          currentWeightKg: weight,
          goalWeightKg: goalWeight,
        ),
      );
      FocusScope.of(context).unfocus();
    }
  }

  bool get _isFormValid {
    return _heightController.text.isNotEmpty &&
        _weightController.text.isNotEmpty &&
        _goalWeightController.text.isNotEmpty &&
        double.tryParse(_heightController.text) != null &&
        double.tryParse(_weightController.text) != null &&
        double.tryParse(_goalWeightController.text) != null;
  }

  @override
  Widget build(BuildContext context) {
    return HideKeyboardOnTap(
      child: Scaffold(
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
                                  colors: [
                                    Color(0xFF1E88E5),
                                    Color(0xFF42A5F5),
                                  ],
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
                                Icons.straighten_outlined,
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
                          'Just a few more questions',
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
                          'This helps us calculate your daily calorie goal.',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Height input
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(30 * (1 - value), 0),
                            child: Opacity(opacity: value, child: child),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How tall are you?',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    focusNode: _focusHeightNode,
                                    textInputAction: TextInputAction.next,
                                    onSubmitted: (_) {
                                      _focusWeightNode.requestFocus();
                                    },
                                    controller: _heightController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 18.sp),
                                    decoration: InputDecoration(
                                      hintText: 'e.g. 165',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.grey[200]!,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.grey[200]!,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        borderSide: BorderSide(
                                          color: Color(0xFF1E88E5),
                                          width: 2,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 16.h,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 16.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1E88E5).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Text(
                                    'cm',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Color(0xFF1E88E5),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Current Weight input
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 450),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(30 * (1 - value), 0),
                            child: Opacity(opacity: value, child: child),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How much do you weigh?',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    focusNode: _focusWeightNode,
                                    textInputAction: TextInputAction.next,
                                    onSubmitted: (_) {
                                      _focusGoalWeightNode.requestFocus();
                                    },
                                    controller: _weightController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 18.sp),
                                    decoration: InputDecoration(
                                      hintText: 'e.g. 58',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.grey[200]!,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.grey[200]!,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        borderSide: BorderSide(
                                          color: Color(0xFF1E88E5),
                                          width: 2,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 16.h,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 16.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1E88E5).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Text(
                                    'kg',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Color(0xFF1E88E5),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'It\'s ok to estimate, you can update this later.',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Goal Weight input
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(30 * (1 - value), 0),
                            child: Opacity(opacity: value, child: child),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'What is your goal weight?',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    focusNode: _focusGoalWeightNode,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    controller: _goalWeightController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 18.sp),
                                    decoration: InputDecoration(
                                      hintText: 'e.g. 55',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.grey[200]!,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.grey[200]!,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        borderSide: BorderSide(
                                          color: Color(0xFF1E88E5),
                                          width: 2,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 16.h,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 16.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1E88E5).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Text(
                                    'kg',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Color(0xFF1E88E5),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Don\'t worry, this doesn\'t affect your daily calorie goal and you can always change it later.',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[500],
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Form completion indicator
                      if (_isFormValid) ...[
                        SizedBox(height: 16.h),
                        AnimatedOpacity(
                          opacity: _isFormValid ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 200),
                          child: Text(
                            'All measurements completed ✓',
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
                  onNext: _isFormValid ? _handleNext : null,
                  onBack: widget.onBack,
                  isNextEnabled: _isFormValid,
                  showBackButton: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
