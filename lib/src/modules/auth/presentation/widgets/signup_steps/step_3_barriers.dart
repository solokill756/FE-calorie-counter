import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/user_profile_model.dart';
import '../common/navigation_buttons.dart';

class Step3Barriers extends StatefulWidget {
  final UserProfileModel userProfile;
  final Function(UserProfileModel) onNext;
  final VoidCallback? onBack;

  const Step3Barriers({
    super.key,
    required this.userProfile,
    required this.onNext,
    this.onBack,
  });

  @override
  State<Step3Barriers> createState() => _Step3BarriersState();
}

class _Step3BarriersState extends State<Step3Barriers> {
  static const String _noKnownAllergies = 'No known food allergies';
  static const String _otherAllergies = 'Other';

  final TextEditingController _otherAllergyController =
      TextEditingController();
  List<String> _selectedAllergies = [];

  final List<String> _availableAllergies = [
    _noKnownAllergies,
    'Peanuts',
    'Tree nuts',
    'Milk or lactose',
    'Eggs',
    'Fish',
    'Shellfish',
    'Soy',
    'Wheat or gluten',
    'Sesame',
    _otherAllergies,
  ];

  @override
  void initState() {
    super.initState();
    final savedAllergies = List<String>.from(widget.userProfile.barriers);
    final knownAllergies = _availableAllergies
        .where((allergy) => allergy != _otherAllergies)
        .toSet();
    final customAllergies = savedAllergies
        .where((allergy) => !knownAllergies.contains(allergy))
        .toList();

    _selectedAllergies = savedAllergies
        .where((allergy) => knownAllergies.contains(allergy))
        .toList();
    if (customAllergies.isNotEmpty) {
      _selectedAllergies.add(_otherAllergies);
      _otherAllergyController.text = customAllergies.join(', ');
    }
  }

  @override
  void dispose() {
    _otherAllergyController.dispose();
    super.dispose();
  }

  void _toggleAllergy(String allergy) {
    setState(() {
      if (allergy == _noKnownAllergies) {
        _selectedAllergies = _selectedAllergies.contains(_noKnownAllergies)
            ? []
            : [_noKnownAllergies];
        return;
      }

      _selectedAllergies.remove(_noKnownAllergies);
      if (allergy == _otherAllergies) {
        if (_selectedAllergies.contains(allergy)) {
          _selectedAllergies.remove(allergy);
        } else {
          _selectedAllergies.add(allergy);
        }
        return;
      }

      if (_selectedAllergies.contains(allergy)) {
        _selectedAllergies.remove(allergy);
      } else {
        _selectedAllergies.add(allergy);
      }
    });
  }

  void _handleNext() {
    final allergies = _selectedAllergies.contains(_noKnownAllergies)
        ? <String>[]
        : _effectiveAllergies;
    widget.onNext(widget.userProfile.copyWith(barriers: allergies));
  }

  List<String> get _effectiveAllergies {
    final allergies = _selectedAllergies
        .where(
          (allergy) =>
              allergy != _noKnownAllergies && allergy != _otherAllergies,
        )
        .toList();
    if (_selectedAllergies.contains(_otherAllergies)) {
      allergies.addAll(
        _otherAllergyController.text
            .split(',')
            .map((value) => value.trim())
            .where((value) => value.isNotEmpty),
      );
    }
    return {...allergies}.toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasSelection = _selectedAllergies.isNotEmpty;
    final showOtherInput = _selectedAllergies.contains(_otherAllergies);
    final selectedAllergyCount = _effectiveAllergies.length;

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
                              Icons.no_food_outlined,
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
                        'Do you have any food allergies or intolerances?',
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
                        'Select all that apply so we can tailor meals and recommendations safely.',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Allergies selection list
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _availableAllergies.length,
                      itemBuilder: (context, index) {
                        final allergy = _availableAllergies[index];
                        final isSelected = _selectedAllergies.contains(allergy);

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
                                onTap: () => _toggleAllergy(allergy),
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
                                          allergy,
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

                    if (showOtherInput) ...[
                      SizedBox(height: 4.h),
                      TextField(
                        controller: _otherAllergyController,
                        textInputAction: TextInputAction.done,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Enter other allergies',
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(color: Colors.grey[200]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide(color: Colors.grey[200]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: const BorderSide(
                              color: Color(0xFF1E88E5),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],

                    // Selection indicator
                    if (hasSelection) ...[
                      SizedBox(height: 16.h),
                      AnimatedOpacity(
                        opacity: hasSelection ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 200),
                        child: Text(
                          _selectedAllergies.contains(_noKnownAllergies)
                              ? 'No allergies selected'
                              : selectedAllergyCount == 0
                                  ? 'Enter an allergy name'
                                  : '$selectedAllergyCount allerg${selectedAllergyCount > 1 ? 'ies' : 'y'} selected',
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
                onNext: _handleNext,
                onBack: widget.onBack,
                isNextEnabled: true,
                showBackButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
