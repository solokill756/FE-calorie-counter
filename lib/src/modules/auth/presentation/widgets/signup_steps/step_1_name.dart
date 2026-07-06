import 'package:caloriecounter/src/common/widgets/hide_keyboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/user_profile_model.dart';
import '../common/navigation_buttons.dart';

class Step1Name extends StatefulWidget {
  final UserProfileModel userProfile;
  final Function(UserProfileModel) onNext;
  final VoidCallback? onBack;

  const Step1Name({
    super.key,
    required this.userProfile,
    required this.onNext,
    this.onBack,
  });

  @override
  State<Step1Name> createState() => _Step1NameState();
}

class _Step1NameState extends State<Step1Name> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userProfile.displayName ?? '';
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleNext() {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      widget.onNext(widget.userProfile.copyWith(displayName: name));
    }
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _nameController.text.trim().isNotEmpty;

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
                                Icons.person_outline_rounded,
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
                          'First, what can we call you?',
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
                          'We\'d like to get to know you better.',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Input field with modern design
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: _isFocused
                              ? [
                                  BoxShadow(
                                    color: Color(0xFF1E88E5).withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedDefaultTextStyle(
                              duration: Duration(milliseconds: 200),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: _isFocused
                                    ? Color(0xFF1E88E5)
                                    : Colors.grey[700],
                              ),
                              child: Text('Preferred first name'),
                            ),
                            SizedBox(height: 10.h),
                            TextField(
                              controller: _nameController,
                              focusNode: _focusNode,
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter your name',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.normal,
                                ),
                                filled: true,
                                fillColor: _isFocused
                                    ? Color(0xFF1E88E5).withOpacity(0.05)
                                    : Colors.grey[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide(
                                    color: Colors.grey[200]!,
                                    width: 2,
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
                                  horizontal: 18.w,
                                  vertical: 16.h,
                                ),
                                suffixIcon: hasText
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF4CAF50),
                                          size: 22.sp,
                                        ),
                                        onPressed: null,
                                      )
                                    : null,
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),

                      // Character count (optional)
                      if (hasText) ...[
                        SizedBox(height: 6.h),
                        AnimatedOpacity(
                          opacity: hasText ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 200),
                          child: Text(
                            '${_nameController.text.length} characters',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.grey[500],
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
                  onNext: hasText ? _handleNext : null,
                  onBack: widget.onBack,
                  isNextEnabled: hasText,
                  showBackButton: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
