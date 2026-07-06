import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widgets/date_picker_widget.dart';
import '../application/diary_cubit/diary_cubit.dart';
import '../application/diary_cubit/diary_state.dart';

class DiaryHeader extends StatelessWidget {
  const DiaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DiaryCubit, DiaryState, DateTime>(
      selector: (state) => state.selectedDate,
      builder: (context, selectedDate) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => context.read<DiaryCubit>().previousDay(),
                      icon: Icon(Icons.chevron_left, size: 28.sp),
                    ),
                    DatePickerButton(
                      selectedDate: selectedDate,
                      onDateChanged: (date) {
                        context.read<DiaryCubit>().changeDate(date);
                      },
                      format: 'MMM d',
                    ),
                    IconButton(
                      onPressed: () => context.read<DiaryCubit>().nextDay(),
                      icon: Icon(Icons.chevron_right, size: 28.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
