import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../data/services/api/nutrition_api_service.dart';
import '../../data/services/nutrition_csv_export_service.dart';

class ExportInformationPage extends StatelessWidget {
  final DateTime currentDate;
  final String period;

  const ExportInformationPage({
    super.key,
    required this.currentDate,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // What information will be exported? Section
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What information will be exported?',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'The CSV includes meal-level nutrition details for the selected date range.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Where will the information be sent? Section
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Where will the information be sent?',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'A CSV file will be created on this device and opened in the share sheet.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  SizedBox(height: 80.h), // Extra space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomButton(context),
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
        'Export Information',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Black line at bottom
          Container(
            width: 134.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2.5.r),
            ),
          ),
          SizedBox(height: 20.h),
          // Export button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                _exportNutrition(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              child: Text(
                'Export My Information',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _exportNutrition(BuildContext context) async {
    final service = NutritionCsvExportService(getIt<NutritionApiService>());
    try {
      context.showLoadingDialog(message: 'Exporting nutrition data...');
      final filePath = await service.exportNutritionToCsv(
        currentDate: currentDate,
        period: period,
      );
      if (context.mounted) context.hideLoadingDialog();

      if (filePath == null) {
        AppDialogs.showWarningSnackBar(message: 'No nutrition data to export');
        return;
      }

      await service.shareCsvFile(filePath);
      AppDialogs.showSuccessSnackBar(
        message: 'Nutrition data exported successfully',
      );
    } catch (_) {
      if (context.mounted) context.hideLoadingDialog();
      AppDialogs.showErrorSnackBar(message: 'Failed to export nutrition data');
    }
  }
}
