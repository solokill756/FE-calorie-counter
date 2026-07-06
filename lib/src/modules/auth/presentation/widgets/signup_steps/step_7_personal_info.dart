import 'package:caloriecounter/src/common/widgets/hide_keyboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/user_profile_model.dart';
import '../common/navigation_buttons.dart';

class Step7PersonalInfo extends StatefulWidget {
  final UserProfileModel userProfile;
  final Function(UserProfileModel) onNext;
  final VoidCallback? onBack;

  const Step7PersonalInfo({
    super.key,
    required this.userProfile,
    required this.onNext,
    this.onBack,
  });

  @override
  State<Step7PersonalInfo> createState() => _Step7PersonalInfoState();
}

class _Step7PersonalInfoState extends State<Step7PersonalInfo> {
  String _selectedGender = '';
  final TextEditingController _ageController = TextEditingController();
  String _selectedCountry = 'Vietnam';
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.userProfile.gender.isNotEmpty
        ? widget.userProfile.gender
        : '';
    _ageController.text = widget.userProfile.age > 0
        ? widget.userProfile.age.toString()
        : '';
    _selectedCountry = widget.userProfile.country.isNotEmpty
        ? widget.userProfile.country
        : 'United States';
    // Default to United States
  }

  @override
  void dispose() {
    _ageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleNext() {
    final age = int.tryParse(_ageController.text) ?? 0;
    if (_selectedGender.isNotEmpty && age > 0) {
      widget.onNext(
        widget.userProfile.copyWith(
          gender: _selectedGender,
          age: age,
          country: _selectedCountry,
        ),
      );
      FocusScope.of(context).unfocus();
    }
  }

  bool get _isFormValid {
    return _selectedGender.isNotEmpty &&
        _ageController.text.isNotEmpty &&
        int.tryParse(_ageController.text) != null;
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
                                    // ignore: deprecated_member_use
                                    color: Color(0xFF1E88E5).withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.person_outline,
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
                          'Tell us a little bit about yourself',
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
                          'This helps us calculate your personalized calorie needs.',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Gender Selection with animation
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
                              'Please select which sex we should use to calculate your calorie needs:',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Material(
                                    borderRadius: BorderRadius.circular(16.r),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedGender = 'Male';
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 16.h,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: _selectedGender == 'Male'
                                                ? Color(0xFF1E88E5)
                                                : Colors.grey[200]!,
                                            width: _selectedGender == 'Male'
                                                ? 2
                                                : 1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16.r,
                                          ),
                                          color: _selectedGender == 'Male'
                                              ? Color(
                                                  0xFF1E88E5,
                                                  // ignore: deprecated_member_use
                                                ).withOpacity(0.05)
                                              : Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Male',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color: _selectedGender == 'Male'
                                                    ? Color(0xFF1E88E5)
                                                    : Colors.black87,
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            if (_selectedGender == 'Male')
                                              AnimatedContainer(
                                                duration: Duration(
                                                  milliseconds: 200,
                                                ),
                                                width: 20.w,
                                                height: 20.h,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF1E88E5),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 14.sp,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Material(
                                    borderRadius: BorderRadius.circular(16.r),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedGender = 'Female';
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 16.h,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: _selectedGender == 'Female'
                                                ? Color(0xFF1E88E5)
                                                : Colors.grey[200]!,
                                            width: _selectedGender == 'Female'
                                                ? 2
                                                : 1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16.r,
                                          ),
                                          color: _selectedGender == 'Female'
                                              ? Color(
                                                  0xFF1E88E5,
                                                ).withOpacity(0.05)
                                              : Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Female',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    _selectedGender == 'Female'
                                                    ? Color(0xFF1E88E5)
                                                    : Colors.black87,
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            if (_selectedGender == 'Female')
                                              AnimatedContainer(
                                                duration: Duration(
                                                  milliseconds: 200,
                                                ),
                                                width: 20.w,
                                                height: 20.h,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF1E88E5),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 14.sp,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Which one should I choose?',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Age input with animation
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
                              'How old are you?',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            TextField(
                              focusNode: _focusNode,
                              controller: _ageController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 18.sp),
                              decoration: InputDecoration(
                                hintText: 'e.g. 25',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide(
                                    color: Colors.grey[200]!,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide(
                                    color: Colors.grey[200]!,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
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
                            SizedBox(height: 8.h),
                            Text(
                              'We use sex at birth and age to calculate an accurate goal for you.',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[500],
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Country picker with animation
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
                        // child: ModernCountryPicker(
                        //   label: 'Where do you live?',
                        //   hint: 'Select your country',
                        //   initialCountryCode: _selectedCountryCode,
                        //   showFlag: true,
                        //   onCountryChanged: (Country country) {
                        //     setState(() {
                        //       _selectedCountry = country.name;
                        //       _selectedCountryCode = country.countryCode;
                        //     });
                        //   },
                        // ),
                      ),

                      // Form completion indicator
                      if (_isFormValid) ...[
                        SizedBox(height: 16.h),
                        AnimatedOpacity(
                          opacity: _isFormValid ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 200),
                          child: Text(
                            'Personal information completed ✓',
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
