import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../generated/assets.gen.dart';
import '../../modules/app/app_router.dart';
import '../../common/extensions/int_duration.dart';
import '../../common/utils/getit_utils.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
    fetchAll();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  fetchAll() async {
    await Future.delayed(3.seconds);
    if (mounted) {
      getIt<AppRouter>().replaceAll([const MainRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2EBD6B), // Vibrant green
              Color(0xFFF9C609), // Golden yellow
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Beautiful animated center logo & typography
              Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Centered Logo
                      SizedBox(
                        width: 130.w,
                        child: Assets.appImages.logo.image(
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // Premium App Title
                      Text(
                        'CALORIE COUNTER',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 4.w,
                          shadows: const [
                            Shadow(
                              color: Color(0x26000000), // 15% opacity black
                              offset: Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      // Elegant subtitle
                      Text(
                        'AI NUTRITION COACH',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xE6FFFFFF), // 90% opacity white
                          letterSpacing: 2.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Clean white progress indicator at the bottom
              Positioned(
                bottom: 40.h,
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: CircularProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2.5.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
