import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    this.showPremiumButton = true,
    this.onPremiumTap,
    this.onNotificationTap,
    this.onProfileTap,
    required this.avatarLink,
  });

  final bool showPremiumButton;
  final VoidCallback? onPremiumTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final String? avatarLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          // Profile Avatar (Left)
          GestureDetector(
            onTap: onProfileTap,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!, width: 1.w),
              ),
              child: Center(
                child:
                    avatarLink != null &&
                        avatarLink!.isNotEmpty &&
                        Uri.tryParse(avatarLink!) != null
                    ? CircleAvatar(
                        radius: 18.r,
                        backgroundImage: NetworkImage(avatarLink!),
                        backgroundColor: Colors.grey[200],
                        onBackgroundImageError: (exception, stackTrace) {
                          // Handle image loading error
                          debugPrint('Error loading avatar image: $exception');
                        },
                      )
                    : CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Color(0xFF4285F4),
                        child: Icon(
                          Icons.person,
                          size: 20.sp,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),

          // Center section with app title and premium badge
          Expanded(
            child: Column(
              children: [
                // App Title with trademark
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Calorie Counter',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '™',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                // Premium badge positioned below the logo
                // if (showPremiumButton)
                //   GestureDetector(
                //     onTap: onPremiumTap,
                //     child: Container(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: 12.w,
                //         vertical: 6.h,
                //       ),
                //       decoration: BoxDecoration(
                //         gradient: LinearGradient(
                //           colors: [
                //             Color(0xFFFFD700), // Gold color
                //             Color(0xFFFFA500), // Orange-gold
                //           ],
                //           begin: Alignment.topCenter,
                //           end: Alignment.bottomCenter,
                //         ),
                //         borderRadius: BorderRadius.circular(15.r),
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.orange.withOpacity(0.2),
                //             blurRadius: 2,
                //             offset: const Offset(0, 1),
                //           ),
                //         ],
                //       ),
                //       child: Text(
                //         'Premium',
                //         style: TextStyle(
                //           color: Colors.black87,
                //           fontSize: 12.sp,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),

          // Notification Icon (Right)
          GestureDetector(
            onTap: onNotificationTap,
            child: Icon(
              Icons.notifications_outlined,
              size: 24.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
