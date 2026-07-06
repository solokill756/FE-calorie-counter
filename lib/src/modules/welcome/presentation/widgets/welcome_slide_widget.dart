import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/welcome_slide_entity.dart';

class WelcomeSlideWidget extends StatelessWidget {
  final WelcomeSlideEntity slide;

  const WelcomeSlideWidget({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // Main Image/Card with content
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 15.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: _buildSlideContent(),
              ),
            ),
          ),

          // Description Text
          Container(
            height: 80.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Center(
              child: Text(
                slide.description,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlideContent() {
    // Since we don't have actual images, I'll create styled containers
    // representing each slide with different content
    switch (slide.description) {
      case 'Ready for some wins? Start tracking, it\'s easy!':
        return _buildFirstSlide();
      case 'Discover the impact of your food and fitness':
        return _buildSecondSlide();
      case 'And make mindful eating a habit for life':
        return _buildThirdSlide();
      default:
        return _buildFirstSlide();
    }
  }

  Widget _buildFirstSlide() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF64B5F6), Color(0xFF1976D2)],
        ),
      ),
      child: Stack(
        children: [
          // Background person image placeholder
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
              child: Icon(
                Icons.person,
                size: 200.sp,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),

          // Protein chart overlay
          Positioned(
            bottom: 80.h,
            left: 30.w,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Protein',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Last 7 days',
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      ...List.generate(
                        7,
                        (index) => Container(
                          width: 8.w,
                          height: (20 + index * 5).h,
                          margin: EdgeInsets.only(right: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'M T W T F S S',
                    style: TextStyle(color: Colors.white70, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondSlide() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF6B6B), Color(0xFFFFE66D), Color(0xFF4ECDC4)],
        ),
      ),
      child: Stack(
        children: [
          // Phone mockup
          Center(
            child: Container(
              width: 220.w,
              height: 320.h,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12.r,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          size: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'myfitnesspal',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'PREMIUM 👑',
                              style: TextStyle(
                                fontSize: 7.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.notifications_outlined, size: 12.sp),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Today section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Edit',
                        style: TextStyle(fontSize: 10.sp, color: Colors.blue),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Calories circle
                  SizedBox(
                    height: 80.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 70.w,
                          height: 70.h,
                          child: CircularProgressIndicator(
                            value: 0.7,
                            strokeWidth: 6.w,
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.blue,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1,250',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Remaining',
                              style: TextStyle(
                                fontSize: 8.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Stats row
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCompactStat('🎯', 'Base Goal', '1,500'),
                        _buildCompactStat('🍽️', 'Food', '650'),
                        _buildCompactStat('🔥', 'Exercise', '400'),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Bottom section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Steps',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '6,342',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                          Text(
                            'Goal: 15,000',
                            style: TextStyle(
                              fontSize: 7.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Exercise',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '400 cal',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          Text(
                            '0:23 hr',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThirdSlide() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE8F5E8), Color(0xFFF0F8F0)],
        ),
      ),
      child: Stack(
        children: [
          // Food bowl image placeholder
          Center(
            child: Container(
              width: 280.w,
              height: 300.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/app_images/Gemini_Generated_Image_zd6fanzd6fanzd6f.png',
                  ), // Using existing logo as placeholder
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green.withOpacity(0.3),
                      Colors.orange.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Nutrition info overlay
          Positioned(
            left: 30.w,
            top: 100.h,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNutritionItem('Protein', '32', Colors.orange),
                  SizedBox(height: 12.h),
                  _buildNutritionItem('Fat', '20', Colors.purple),
                  SizedBox(height: 12.h),
                  _buildNutritionItem('Carbs', '57', Colors.teal),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactStat(String icon, String label, String value) {
    return Column(
      children: [
        Text(icon, style: TextStyle(fontSize: 12.sp)),
        Text(
          label,
          style: TextStyle(fontSize: 6.sp, color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildNutritionItem(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 30.w,
          height: 30.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 3.w),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
