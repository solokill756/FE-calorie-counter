import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/user_profile_model.dart';
import '../common/health_profile_options.dart';
import '../common/navigation_buttons.dart';

class Step4Medical extends StatefulWidget {
  final UserProfileModel userProfile;
  final Function(UserProfileModel) onNext;
  final VoidCallback? onBack;

  const Step4Medical({
    super.key,
    required this.userProfile,
    required this.onNext,
    this.onBack,
  });

  @override
  State<Step4Medical> createState() => _Step4MedicalState();
}

class _Step4MedicalState extends State<Step4Medical> {
  static final _conditions = medicalConditionOptions.entries.toList();

  final Set<String> _selected = {};
  bool _declaredNone = false;

  @override
  void initState() {
    super.initState();
    final existing = widget.userProfile.conditionTypes;
    if (existing.isEmpty) {
      _declaredNone = false;
    } else {
      _selected.addAll(existing);
      _declaredNone = false;
    }
  }

  bool get _canProceed => _declaredNone || _selected.isNotEmpty;

  void _toggleCondition(String value) {
    setState(() {
      _declaredNone = false;
      if (_selected.contains(value)) {
        _selected.remove(value);
      } else {
        _selected.add(value);
      }
    });
  }

  void _setNone() {
    setState(() {
      _declaredNone = true;
      _selected.clear();
    });
  }

  void _handleNext() {
    if (!_canProceed) return;
    final types = _declaredNone ? <String>[] : _selected.toList()..sort();
    widget.onNext(
      widget.userProfile.copyWith(
        conditionTypes: types,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                              Icons.medical_services_outlined,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Any medical conditions?',
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.2,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Select conditions that apply, or tap "None" if you have none to report. This helps us set safer nutrition targets.',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Material(
                      borderRadius: BorderRadius.circular(16.r),
                      child: InkWell(
                        onTap: _setNone,
                        borderRadius: BorderRadius.circular(16.r),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 16.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _declaredNone
                                  ? const Color(0xFF1E88E5)
                                  : Colors.grey[200]!,
                              width: _declaredNone ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                            color: _declaredNone
                                ? const Color(0xFF1E88E5).withOpacity(0.05)
                                : Colors.white,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'None — I have no conditions to report',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: _declaredNone
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: _declaredNone
                                        ? const Color(0xFF1E88E5)
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                              if (_declaredNone)
                                Icon(
                                  Icons.check_circle,
                                  color: const Color(0xFF1E88E5),
                                  size: 22.sp,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _conditions.length,
                      itemBuilder: (context, index) {
                        final item = _conditions[index];
                        final value = item.key;
                        final label = item.value;
                        final isSelected = _selected.contains(value);

                        return Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          child: Material(
                            borderRadius: BorderRadius.circular(16.r),
                            child: InkWell(
                              onTap: () => _toggleCondition(value),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            label,
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
                                    if (isSelected) ...[
                                      SizedBox(height: 12.h),
                                    ],
                                  ],
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
                onNext: _handleNext,
                onBack: widget.onBack,
                isNextEnabled: _canProceed,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
