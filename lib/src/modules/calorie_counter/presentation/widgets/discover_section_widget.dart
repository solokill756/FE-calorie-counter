import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widgets/calorie_card_widget.dart';

class DiscoverSectionWidget extends StatelessWidget {
  const DiscoverSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final discoverItems = [
      {
        'title': 'Sleep',
        'icon': Icons.bedtime,
        'subtitle': 'Eat right, sleep tight',
      },
      {
        'title': 'Recipes',
        'icon': Icons.restaurant_menu,
        'subtitle': 'Cook, eat, log, repeat',
      },
      {
        'title': 'Workouts',
        'icon': Icons.fitness_center,
        'subtitle': 'Sweating is self-care',
      },
      {
        'title': 'Sync up',
        'icon': Icons.sync,
        'subtitle': 'Link apps & devices',
      },
      {
        'title': 'Friends',
        'icon': Icons.people,
        'subtitle': 'Your support squad',
      },
      {
        'title': 'Community',
        'icon': Icons.chat_bubble,
        'subtitle': 'Food & fitness inspo',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Discover',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: 1.2,
          ),
          itemCount: discoverItems.length,
          itemBuilder: (context, index) {
            final item = discoverItems[index];
            return DiscoverCardWidget(
              title: item['title'] as String,
              icon: item['icon'] as IconData,
              subtitle: item['subtitle'] as String,
              index: index,
            );
          },
        ),
      ],
    );
  }
}

class DiscoverCardWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;
  final int index;

  const DiscoverCardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Transform.scale(
            scale: 0.8 + (0.2 * value),
            child: Opacity(opacity: value, child: child),
          ),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200 + (index * 50)),
        curve: Curves.easeInOut,
        child: CalorieCardWidget(
          child: InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              // Handle discover card navigation
            },
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.all(8.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 800 + (index * 100)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: 0.1 * (1 - value),
                        child: Icon(
                          icon,
                          size: 28.sp,
                          color: Color.lerp(Colors.grey, Colors.blue, value),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
