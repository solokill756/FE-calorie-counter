import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InitialLoadingOverlayWidget extends StatelessWidget {
  final Animation<double> loadingAnimation;

  const InitialLoadingOverlayWidget({
    super.key,
    required this.loadingAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: loadingAnimation,
      builder: (context, child) {
        return Container(
          color: Colors.grey[50]?.withOpacity(1 - loadingAnimation.value),
          child: Center(
            child: Transform.scale(
              scale: 1 - loadingAnimation.value,
              child: Opacity(
                opacity: 1 - loadingAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 2000),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.rotate(
                          angle: value * 2 * 3.14159,
                          child: const CircularProgressIndicator(),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Welcome to Dashboard',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
