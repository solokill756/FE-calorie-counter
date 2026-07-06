import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/app_router.dart';
import '../../data/welcome_data.dart';
import '../widgets/welcome_slide_widget.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with title
            Padding(
              padding: EdgeInsets.only(top: 30.h, bottom: 15.h),
              child: Column(
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Calorie Counter',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E88E5),
                    ),
                  ),
                ],
              ),
            ),

            // Carousel
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount: WelcomeData.slides.length,
                      itemBuilder: (context, index, realIndex) {
                        final slide = WelcomeData.slides[index];
                        return WelcomeSlideWidget(slide: slide);
                      },
                      options: CarouselOptions(
                        height: double.infinity,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),

                  // Page Indicator
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: AnimatedSmoothIndicator(
                      activeIndex: _currentIndex,
                      count: WelcomeData.slides.length,
                      effect: WormEffect(
                        dotHeight: 8.h,
                        dotWidth: 8.w,
                        activeDotColor: const Color(0xFF1E88E5),
                        dotColor: Colors.grey[300]!,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Buttons
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 24.h),
              child: Column(
                children: [
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: _navigateToSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: _navigateToRegister,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: const Color(0xFF1976D2),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        foregroundColor: const Color(0xFF1976D2),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSignUp() {
    context.router.push(const LoginRoute());
  }

  void _navigateToRegister() {
    context.router.push(const RegisterRoute());
  }
}
