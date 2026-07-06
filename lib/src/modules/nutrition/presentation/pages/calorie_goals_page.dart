import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../modules/auth/presentation/application/cubit/user_profile_access.dart';
import 'add_daily_goal_page.dart';

class CalorieGoalsPage extends StatelessWidget {
  const CalorieGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get user profile from storage
    final userProfile = readServerProfile();

    // Calculate goals based on user profile
    final dailyCalories = userProfile?.resolvedDailyCalorieGoal() ?? 2220;
    final macroGoals =
        userProfile?.macroGoals ??
        {
          'carbsG': 278.0,
          'proteinG': 111.0,
          'fatG': 74.0,
          'carbsPercent': 50.0,
          'proteinPercent': 20.0,
          'fatPercent': 30.0,
        };

    // Format values
    final caloriesFormatted = _formatNumber(dailyCalories);
    final carbsG = (macroGoals['carbsG'] as double).round();
    final proteinG = (macroGoals['proteinG'] as double).round();
    final fatG = (macroGoals['fatG'] as double).round();
    final carbsPercent = (macroGoals['carbsPercent'] as double).round();
    final proteinPercent = (macroGoals['proteinPercent'] as double).round();
    final fatPercent = (macroGoals['fatPercent'] as double).round();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // Default Goal Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Default Goal',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Goals List
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildGoalRow('Calories', caloriesFormatted),
                  _buildDivider(),
                  _buildGoalRow('Carbohydrates', '$carbsG g', '$carbsPercent%'),
                  _buildDivider(),
                  _buildGoalRow('Protein', '$proteinG g', '$proteinPercent%'),
                  _buildDivider(),
                  _buildGoalRow('Fat', '$fatG g', '$fatPercent%'),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            // Custom Daily Goals Section
            Container(
              color: Colors.grey[100],
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Text(
                'Custom Daily Goals',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ),

            // Add Daily Goal Button
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddDailyGoalPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Add Daily Goal',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 60.h),

            // How we make recommendations
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16.sp,
                    color: Colors.grey[500],
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'How we make recommendations',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Calorie & Macro Goals',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildGoalRow(String name, String value, [String? percentage]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
          if (percentage != null)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Text(
                percentage,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[600],
                ),
              ),
            ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Colors.grey[300],
      margin: EdgeInsets.only(left: 20.w),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
