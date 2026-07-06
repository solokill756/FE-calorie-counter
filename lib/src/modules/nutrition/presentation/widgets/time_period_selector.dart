import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef NutritionPeriodChanged =
    void Function(String period, {DateTime? selectedDate});

class TimePeriodSelector extends StatefulWidget {
  final String selectedPeriod;
  final NutritionPeriodChanged onPeriodChanged;
  final VoidCallback onPreviousPeriod;
  final VoidCallback onNextPeriod;
  final DateTime? currentDate;

  const TimePeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
    required this.onPreviousPeriod,
    required this.onNextPeriod,
    this.currentDate,
  });

  @override
  State<TimePeriodSelector> createState() => _TimePeriodSelectorState();
}

class _TimePeriodSelectorState extends State<TimePeriodSelector> {
  static const int _minYear = 2020;
  static const int _maxYear = 2035;

  bool _isDropdownOpen = false;
  DateTime? _selectedDate;
  FixedExtentScrollController? _dayController;
  FixedExtentScrollController? _monthController;
  FixedExtentScrollController? _yearController;

  // Wheel picker states
  int _selectedDay = DateTime.now().day;
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  @override
  void dispose() {
    _dayController?.dispose();
    _monthController?.dispose();
    _yearController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              // Main content với 3 cột: Arrow | Center | Arrow
              SizedBox(
                height: 65.h, // Fixed height
                child: Row(
                  children: [
                    // Left Arrow - Cột riêng với border phải
                    Container(
                      width: 60.w,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.grey[300]!, width: 1),
                        ),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.chevron_left,
                            size: 24.sp,
                            color: Colors.black87,
                          ),
                          onPressed: widget.onPreviousPeriod,
                        ),
                      ),
                    ),

                    // Center content - Expanded
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Period selector (Day View/Week View) - clickable with dropdown arrow
                            GestureDetector(
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    _isDropdownOpen = !_isDropdownOpen;
                                  });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.selectedPeriod,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    _isDropdownOpen
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 16.sp,
                                    color: Colors.grey[600],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 4.h),

                            // Date display (Today/Last 7 Days/Selected Date)
                            Text(
                              _getDisplayText(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Right Arrow - Cột riêng với border trái
                    Container(
                      width: 60.w,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.grey[300]!, width: 1),
                        ),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.chevron_right,
                            size: 24.sp,
                            color: Colors.black87,
                          ),
                          onPressed: widget.onNextPeriod,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Full width dropdown menu
              if (_isDropdownOpen)
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      _buildDropdownItem('Day View'),
                      _buildDropdownItem('Week View'),
                      _buildDropdownItem('Month View'),
                      _buildDropdownItem('Change Date'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _getDisplayText() {
    final date = widget.currentDate ?? _selectedDate ?? DateTime.now();
    if (widget.selectedPeriod == 'Week View') {
      final startDate = date.subtract(const Duration(days: 6));
      final endDate = date;

      // Format: "25 Dec - 31 Dec" or "25 Dec 2024 - 31 Dec 2024" if different year
      if (startDate.year == endDate.year) {
        if (startDate.month == endDate.month) {
          return '${startDate.day} - ${endDate.day} ${_getMonthName(endDate.month)}';
        } else {
          return '${startDate.day} ${_getMonthName(startDate.month)} - ${endDate.day} ${_getMonthName(endDate.month)}';
        }
      } else {
        return '${startDate.day} ${_getMonthName(startDate.month)} ${startDate.year} - ${endDate.day} ${_getMonthName(endDate.month)} ${endDate.year}';
      }
    } else if (widget.selectedPeriod == 'Day View') {
      final today = DateTime.now();

      if (date.year == today.year &&
          date.month == today.month &&
          date.day == today.day) {
        return 'Today';
      } else {
        return '${date.day} ${_getMonthName(date.month)} ${date.year}';
      }
    } else if (widget.selectedPeriod == 'Month View') {
      return '${_getMonthName(date.month)} ${date.year}';
    }
    return 'Last 7 Days';
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month];
  }

  void _showDatePicker() {
    if (!mounted) return;

    _prepareDatePickerState();

    setState(() {
      _isDropdownOpen = false;
    });

    // Sử dụng modal dialog thay vì overlay để tránh overflow
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return Dialog(
            insetPadding: EdgeInsets.all(20.w),
            backgroundColor:
                Colors.transparent, // Transparent để hiển thị custom background
            child: _buildDatePicker(dialogContext),
          );
        },
      );
    }
  }

  void _hideDatePicker(BuildContext dialogContext) {
    if (Navigator.of(dialogContext).canPop()) {
      Navigator.of(dialogContext).pop();
    }
  }

  void _selectDate(BuildContext dialogContext, DateTime date) {
    if (Navigator.of(dialogContext).canPop()) {
      Navigator.of(dialogContext).pop();
    }
    if (mounted) {
      setState(() {
        _selectedDate = date;
      });
      widget.onPeriodChanged(widget.selectedPeriod, selectedDate: date);
    }
  }

  void _selectDateFromWheels(BuildContext dialogContext) {
    final selectedDate = DateTime(
      _selectedYear,
      _selectedMonth,
      _selectedDay
          .clamp(1, _daysInMonth(_selectedYear, _selectedMonth))
          .toInt(),
    );
    _selectDate(dialogContext, selectedDate);
  }

  Widget _buildDropdownItem(String value) {
    final isSelected = value == widget.selectedPeriod;
    return GestureDetector(
      onTap: () {
        if (value == 'Change Date') {
          if (mounted) {
            setState(() {
              _isDropdownOpen = false;
            });
          }
          _showDatePicker();
        } else {
          widget.onPeriodChanged(value);
          if (mounted) {
            setState(() {
              _isDropdownOpen = false;
              _selectedDate = null; // Reset date khi chọn mode khác
            });
          }
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            color: isSelected ? Colors.black87 : Colors.grey[600],
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext dialogContext) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Màu nền trắng
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(16.w), // Giảm padding
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _hideDatePicker(dialogContext),
                child: Icon(Icons.close, size: 24.sp, color: Colors.black87),
              ),
              Text(
                _getDatePickerTitle(),
                style: TextStyle(
                  fontSize: 16.sp, // Giảm font size
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: () => _selectDateFromWheels(dialogContext),
                child: Icon(Icons.check, size: 24.sp, color: Colors.blue),
              ),
            ],
          ),

          SizedBox(height: 16.h), // Giảm spacing
          // Today button
          GestureDetector(
            onTap: () {
              final today = DateTime.now();
              _selectDate(dialogContext, today);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h), // Giảm padding
              child: Center(
                child: Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 14.sp, // Giảm font size
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h), // Giảm spacing
          // Date Grid - Fixed height thay vì Expanded
          SizedBox(
            height: 160.h, // Compact height cho wheel pickers
            child: Row(
              children: [
                // Day Picker
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Day',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: ListWheelScrollView.useDelegate(
                          controller: _dayController,
                          itemExtent: 40.h,
                          perspective: 0.005,
                          diameterRatio: 1.2,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            if (mounted) {
                              setState(() {
                                  _selectedDay = index + 1;
                              });
                            }
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: _daysInMonth(
                              _selectedYear,
                              _selectedMonth,
                            ),
                            builder: (context, index) {
                              final day = index + 1;
                              return Center(
                                child: Text(
                                  '$day',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Month Picker
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Month',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: ListWheelScrollView.useDelegate(
                          controller: _monthController,
                          itemExtent: 40.h,
                          perspective: 0.005,
                          diameterRatio: 1.2,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            if (mounted) {
                              setState(() {
                                _selectedMonth = index + 1;
                                _clampSelectedDay();
                              });
                            }
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: 12,
                            builder: (context, index) {
                              final month = index + 1;
                              final monthName = _getMonthName(month);
                              return Center(
                                child: Text(
                                  monthName,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Year Picker
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Year',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: ListWheelScrollView.useDelegate(
                          controller: _yearController,
                          itemExtent: 40.h,
                          perspective: 0.005,
                          diameterRatio: 1.2,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            if (mounted) {
                              setState(() {
                                _selectedYear = _minYear + index;
                                _clampSelectedDay();
                              });
                            }
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: _maxYear - _minYear + 1,
                            builder: (context, index) {
                              final year = _minYear + index;
                              return Center(
                                child: Text(
                                  '$year',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getDatePickerTitle() {
    switch (widget.selectedPeriod) {
      case 'Day View':
        return 'Select Date:';
      case 'Month View':
        return 'Select Month:';
      case 'Week View':
      default:
        return 'Week Ending On:';
    }
  }

  void _prepareDatePickerState() {
    final date = widget.currentDate ?? _selectedDate ?? DateTime.now();
    final year = date.year.clamp(_minYear, _maxYear).toInt();
    final month = date.month.clamp(1, 12).toInt();
    final day = date.day.clamp(1, _daysInMonth(year, month)).toInt();

    _selectedYear = year;
    _selectedMonth = month;
    _selectedDay = day;

    _dayController?.dispose();
    _monthController?.dispose();
    _yearController?.dispose();
    _dayController = FixedExtentScrollController(initialItem: day - 1);
    _monthController = FixedExtentScrollController(initialItem: month - 1);
    _yearController = FixedExtentScrollController(initialItem: year - _minYear);
  }

  void _clampSelectedDay() {
    final maxDay = _daysInMonth(_selectedYear, _selectedMonth);
    if (_selectedDay <= maxDay) return;
    _selectedDay = maxDay;
    _dayController?.jumpToItem(maxDay - 1);
  }

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}
