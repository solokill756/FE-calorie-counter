import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../modules/auth/presentation/application/cubit/user_profile_access.dart';
import '../../modules/app/app_router.dart';
import '../constants/ui_constants.dart';
import '../theme/app_shell_ui.dart';
import '../../modules/calorie_counter/domain/entities/calorie_entity.dart';

class CaloriesCarouselWidget extends StatefulWidget {
  const CaloriesCarouselWidget({
    super.key,
    required this.calories,
    this.onCaloriesTap,
    this.todayMacros,
  });

  final Map<String, dynamic> calories;
  final VoidCallback? onCaloriesTap;
  final MacroEntity? todayMacros;

  @override
  State<CaloriesCarouselWidget> createState() => _CaloriesCarouselWidgetState();
}

class _CaloriesCarouselWidgetState extends State<CaloriesCarouselWidget> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _carouselItems = [
    {
      'title': 'Calories',
      'subtitle': 'Remaining = Goal - Food + Exercise',
      'type': 'calories',
    },
    {
      'title': 'Macros',
      'subtitle': 'Track your macronutrients',
      'type': 'macros',
    },
    // {'title': 'Heart Healthy', 'subtitle': '', 'type': 'heart_healthy'},
    // {'title': 'Low Carb', 'subtitle': '', 'type': 'low_carb'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Carousel
        CarouselSlider.builder(
          itemCount: _carouselItems.length,
          itemBuilder: (context, index, realIndex) {
            return _buildCarouselItem(_carouselItems[index]);
          },
          options: CarouselOptions(
            height:
                200.h, // Increased from 160.h to 200.h for better proportions
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            enlargeFactor: 0.1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),

        SizedBox(height: 16.h),

        // Pagination Dots
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: _carouselItems.length,
            effect: WormEffect(
              dotHeight: 8.h,
              dotWidth: 8.w,
              spacing: 8.w,
              dotColor: Colors.grey[300]!,
              activeDotColor: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(Map<String, dynamic> item) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UIConstants.kRadius),
      ),
      child: InkWell(
        onTap: () {
          // Nếu là calories card thì chuyển đến nutrition page
          if (item['type'] == 'calories') {
            context.router.push(const NutritionRoute());
          } else {
            // Gọi callback nếu có cho các card khác
            widget.onCaloriesTap?.call();
          }
        },
        borderRadius: BorderRadius.circular(UIConstants.kRadius),
        child: Padding(
          padding: EdgeInsets.all(12.w), // Reduced from 16.w
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                item['title'],
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              // Subtitle - only show for non-macros types and non-empty subtitles
              if (item['type'] != 'macros' && item['subtitle'].isNotEmpty) ...[
                SizedBox(height: 8.h),
                Text(
                  item['subtitle'],
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                ),
              ],

              SizedBox(height: 12.h), // Reduced from 16.h
              // Content based on type
              Expanded(child: _buildContentByType(item['type'])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentByType(String type) {
    switch (type) {
      case 'calories':
        return _buildCaloriesContent();
      case 'macros':
        return _buildMacrosContent();
      // case 'water':
      //   return _buildWaterContent();
      case 'heart_healthy':
        return _buildHeartHealthyContent();
      case 'low_carb':
        return _buildLowCarbContent();
      // case 'sleep':
      //   return _buildSleepContent();
      default:
        return _buildCaloriesContent();
    }
  }

  Widget _buildCaloriesContent() {
    final goal = widget.calories['goal'] ?? 2220;
    final consumed = widget.calories['consumed'] ?? 0;
    final burned = widget.calories['burned'] ?? 0;
    final remaining = widget.calories['remaining'] ?? goal;

    return Row(
      children: [
        // Circular Progress
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80.w,
                height: 80.w,
                child: CircularProgressIndicator(
                  value: (goal - remaining) / goal,
                  strokeWidth: 8.w,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    remaining.toString(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Remaining',
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Metrics - centered vertically relative to the circle
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMetricRow(
                Icons.flag,
                'Base Goal',
                goal.toString(),
                Colors.grey[600]!,
              ),
              SizedBox(height: 8.h),
              _buildMetricRow(
                Icons.restaurant,
                'Food',
                consumed.toString(),
                Colors.blue[600]!,
              ),
              SizedBox(height: 8.h),
              _buildMetricRow(
                Icons.local_fire_department,
                'Exercise',
                burned.toString(),
                Colors.orange[600]!,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMacrosContent() {
    // Get macro goals from user profile
    final userProfile = readServerProfile();
    final macroGoals =
        userProfile?.macroGoals ??
        {'carbsG': 278.0, 'proteinG': 111.0, 'fatG': 74.0};

    // Get consumed macros from todayMacros
    final consumedCarbs = widget.todayMacros?.carbs ?? 0.0;
    final consumedProtein = widget.todayMacros?.protein ?? 0.0;
    final consumedFat = widget.todayMacros?.fat ?? 0.0;

    // Get goal macros in grams
    final carbsGoal = (macroGoals['carbsG'] as num).toDouble();
    final proteinGoal = (macroGoals['proteinG'] as num).toDouble();
    final fatGoal = (macroGoals['fatG'] as num).toDouble();
    final carbsColor = AppShellUi.macroCarbs(context);
    final fatColor = AppShellUi.macroFat(context);
    final proteinColor = AppShellUi.macroProtein(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildMacroCircle(
          'Carbohydrates',
          consumedCarbs.toInt(),
          carbsGoal.toInt(),
          carbsColor,
        ),
        _buildMacroCircle(
          'Fat',
          consumedFat.toInt(),
          fatGoal.toInt(),
          fatColor,
        ),
        _buildMacroCircle(
          'Protein',
          consumedProtein.toInt(),
          proteinGoal.toInt(),
          proteinColor,
        ),
      ],
    );
  }

  Widget _buildMacroCircle(String label, int consumed, int goal, Color color) {
    // Calculate progress value, ensuring it's between 0 and 1
    final progressValue = goal > 0 ? (consumed / goal).clamp(0.0, 1.0) : 0.0;

    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: 75.w,
            height: 75.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 75.w,
                  height: 75.w,
                  child: CircularProgressIndicator(
                    value: progressValue,
                    strokeWidth: 6.w,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        '$consumed',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '/${goal}g',
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${(goal - consumed).clamp(0, goal)}g left',
            style: TextStyle(fontSize: 9.sp, color: Colors.black87),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Widget _buildWaterContent() {
  //   return Row(
  //     children: [
  //       Icon(Icons.water_drop, size: 40.sp, color: Colors.blue),
  //       SizedBox(width: 16.w),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               '0 / 8 glasses',
  //               style: TextStyle(
  //                 fontSize: 16.sp,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             SizedBox(height: 8.h),
  //             LinearProgressIndicator(
  //               value: 0,
  //               backgroundColor: Colors.grey[300],
  //               valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildHeartHealthyContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNutrientSection('Fat', 0, 74, 'g'),
        SizedBox(height: 12.h),
        _buildNutrientSection('Sodium', 0, 2300, 'mg'),
        SizedBox(height: 12.h),
        _buildNutrientSection('Cholesterol', 0, 300, 'mg'),
      ],
    );
  }

  Widget _buildLowCarbContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNutrientSection('Carbohydrates', 0, 280, 'g'),
        SizedBox(height: 12.h),
        _buildNutrientSection('Sugar', 0, 84, 'g'),
        SizedBox(height: 12.h),
        _buildNutrientSection('Fiber', 0, 38, 'g'),
      ],
    );
  }

  Widget _buildNutrientSection(
    String nutrient,
    int current,
    int target,
    String unit,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                nutrient,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '$current/$target$unit',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        SizedBox(
          height: 6.h,
          child: LinearProgressIndicator(
            value: current / target,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      ],
    );
  }

  // Widget _buildSleepContent() {
  //   return Row(
  //     children: [
  //       Icon(Icons.bedtime, size: 40.sp, color: Colors.purple),
  //       SizedBox(width: 16.w),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               '0 hours',
  //               style: TextStyle(
  //                 fontSize: 16.sp,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             Text(
  //               'Goal: 8 hours',
  //               style: TextStyle(
  //                 fontSize: 12.sp,
  //                 color: Colors.grey[600],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildMetricRow(
    IconData icon,
    String label,
    String value,
    Color iconColor,
  ) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: iconColor),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
