import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget để chọn quốc gia với giao diện đẹp
class CountrySelectorWidget extends StatelessWidget {
  final String? selectedCountryCode;
  final String? selectedCountryName;
  final Function(Country) onCountrySelected;
  final String hintText;
  final bool isRequired;

  const CountrySelectorWidget({
    super.key,
    this.selectedCountryCode,
    this.selectedCountryName,
    required this.onCountrySelected,
    this.hintText = 'Select your country',
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showCountryPicker(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            if (selectedCountryCode != null) ...[
              Text(
                Country.parse(selectedCountryCode!).flagEmoji,
                style: TextStyle(fontSize: 24.sp),
              ),
              SizedBox(width: 12.w),
            ],
            Expanded(
              child: Text(
                selectedCountryName ?? hintText,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: selectedCountryName != null
                      ? Colors.black87
                      : Colors.grey[600],
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey[600],
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: onCountrySelected,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16.sp, color: Colors.black87),
        bottomSheetHeight: 500.h,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom Country Picker Widget với design hiện đại
class ModernCountryPicker extends StatefulWidget {
  final String? initialCountryCode;
  final Function(Country) onCountryChanged;
  final String? label;
  final String? hint;
  final bool showPhoneCode;
  final bool showFlag;
  final bool isRequired;

  const ModernCountryPicker({
    super.key,
    this.initialCountryCode,
    required this.onCountryChanged,
    this.label,
    this.hint,
    this.showPhoneCode = false,
    this.showFlag = true,
    this.isRequired = false,
  });

  @override
  State<ModernCountryPicker> createState() => _ModernCountryPickerState();
}

class _ModernCountryPickerState extends State<ModernCountryPicker> {
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    if (widget.initialCountryCode != null) {
      try {
        selectedCountry = Country.parse(widget.initialCountryCode!);
      } catch (e) {
        // Invalid country code
        selectedCountry = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label! + (widget.isRequired ? ' *' : ''),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8.h),
        ],
        GestureDetector(
          onTap: _openCountryPicker,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!, width: 1.5),
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
            ),
            child: Row(
              children: [
                if (widget.showFlag && selectedCountry != null) ...[
                  Text(
                    selectedCountry!.flagEmoji,
                    style: TextStyle(fontSize: 24.sp),
                  ),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  child: Text(
                    _getDisplayText(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: selectedCountry != null
                          ? Colors.black87
                          : Colors.grey[500],
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey[600],
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getDisplayText() {
    if (selectedCountry == null) {
      return widget.hint ?? 'Select country';
    }

    String text = selectedCountry!.name;
    if (widget.showPhoneCode) {
      text += ' (+${selectedCountry!.phoneCode})';
    }
    return text;
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: widget.showPhoneCode,
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country;
        });
        widget.onCountryChanged(country);
      },
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16.sp, color: Colors.black87),
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.8,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search countries',
          hintText: 'Type country name...',
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Color(0xFF1E88E5)),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
        ),
        searchTextStyle: TextStyle(fontSize: 16.sp, color: Colors.black87),
      ),
    );
  }
}
