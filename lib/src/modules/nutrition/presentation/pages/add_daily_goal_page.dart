import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddDailyGoalPage extends StatefulWidget {
  const AddDailyGoalPage({super.key});

  @override
  State<AddDailyGoalPage> createState() => _AddDailyGoalPageState();
}

class _AddDailyGoalPageState extends State<AddDailyGoalPage> {
  Set<int> selectedDays = <int>{}; // 0 = Monday, 1 = Tuesday, etc.

  final List<String> dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  final List<String> dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // Premium Feature
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Text(
                    '👑',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Premium Feature',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Create Your Own Section
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Your Own',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Select day(s), then adjust calories or macros.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Day Selector
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: List.generate(7, (index) {
                        final isSelected = selectedDays.contains(index);
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedDays.remove(index);
                                } else {
                                  selectedDays.add(index);
                                }
                              });
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.blue : Colors.white,
                                border: index > 0
                                    ? Border(
                                        left: BorderSide(
                                            color: Colors.blue, width: 1),
                                      )
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  dayLabels[index],
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isSelected ? Colors.white : Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Goals List
                  _buildGoalRow('Calories', '2,220'),
                  SizedBox(height: 24.h),
                  _buildGoalRow('Carbohydrates', '278 g', '50%'),
                  SizedBox(height: 24.h),
                  _buildGoalRow('Protein', '111 g', '20%'),
                  SizedBox(height: 24.h),
                  _buildGoalRow('Fat', '74 g', '30%'),
                ],
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
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[500],
                    ),
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
        'Add Daily Goal',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.check, color: Colors.blue, size: 24.sp),
          onPressed: () {
            // Handle save
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _buildGoalRow(String name, String value, [String? percentage]) {
    return Row(
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
    );
  }
}
