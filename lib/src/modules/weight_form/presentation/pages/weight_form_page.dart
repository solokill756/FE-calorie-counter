import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/common/widgets/data_fetch_loading_widget.dart';
import 'package:caloriecounter/src/common/widgets/hide_keyboard_widget.dart';
import 'package:caloriecounter/src/common/widgets/loading_widget.dart';
import 'package:caloriecounter/src/modules/weight_form/presentation/application/cubit/weightForm_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/image_picker_service.dart';
import '../components/date_selector_field.dart';
import '../components/progress_photo_field.dart';
import '../components/weight_form_header.dart';
import '../components/weight_input_field.dart.dart';

@RoutePage()
class WeightFormPage extends StatelessWidget {
  final String? entryId; // Optional entry ID for edit mode

  const WeightFormPage({super.key, this.entryId});

  @override
  Widget build(BuildContext context) {
    return WeightFormView(entryId: entryId);
  }
}

class WeightFormView extends StatefulWidget {
  final String? entryId; // Optional entry ID for edit mode

  const WeightFormView({super.key, this.entryId});

  @override
  State<WeightFormView> createState() => _WeightFormViewState();
}

class _WeightFormViewState extends State<WeightFormView> {
  final TextEditingController _weightController = TextEditingController(
    text: '',
  );
  DateTime _selectedDate = DateTime.now();
  File? _selectedImage; //
  late bool _isEditMode; // Track if this is edit mode
  String? _imagePath;
  bool _isDataLoaded = false; // Flag to load data only once

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.entryId != null;
    if (_isEditMode) {
      context.read<WeightFormCubit>().loadWeightEntry(entryId: widget.entryId!);
    } else {
      // Reset form for add mode
      context.read<WeightFormCubit>().resetForm();
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  void _onWeightChanged(String value) {
    setState(() {
      // Handle weight change
    });
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _onProgressPhotoTap() {
    final scheme = Theme.of(context).colorScheme;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) {
        final s = Theme.of(sheetContext).colorScheme;
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Add Progress Photo',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: s.onSurface,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Choose how you want to add your photo',
                  style: TextStyle(fontSize: 14.sp, color: s.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildPhotoOption(
                        sheetContext,
                        icon: Icons.camera_alt_outlined,
                        title: 'Camera',
                        subtitle: 'Take a new photo',
                        onTap: () {
                          Navigator.of(sheetContext).pop();
                          _handleCamera();
                        },
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _buildPhotoOption(
                        sheetContext,
                        icon: Icons.photo_library_outlined,
                        title: 'Gallery',
                        subtitle: 'Choose from gallery',
                        onTap: () {
                          Navigator.of(sheetContext).pop();
                          _handleGallery();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                TextButton(
                  onPressed: () => Navigator.of(sheetContext).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: s.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhotoOption(
    BuildContext optionContext, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(optionContext).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: scheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.06),
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(icon, size: 24.sp, color: scheme.primary),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12.sp, color: scheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCamera() async {
    try {
      final File? image = await ImagePickerService.takePhoto();
      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
        if (!mounted) return;
        AppDialogs.showSuccessSnackBar(message: 'Photo added successfully');
      }
    } catch (e) {
      if (!mounted) return;
      AppDialogs.showErrorSnackBar(message: 'Failed to take photo');
    }
  }

  Future<void> _handleGallery() async {
    try {
      final File? image = await ImagePickerService.pickFromGallery();
      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
        if (!mounted) return;
        AppDialogs.showSuccessSnackBar(message: 'Photo added successfully');
      }
    } catch (e) {
      if (!mounted) return;
      AppDialogs.showErrorSnackBar(message: 'Failed to select photo');
    }
  }

  void _onSave() {
    FocusScope.of(context).unfocus();
    final trimmed = _weightController.text.trim();
    if (trimmed.isEmpty) {
      AppDialogs.showWarningSnackBar(message: 'Please enter your weight');
      return;
    }
    final weight = double.tryParse(trimmed);
    if (weight == null) {
      AppDialogs.showWarningSnackBar(message: 'Enter a valid weight number');
      return;
    }
    final DateTime date = _selectedDate;
    final String? photoPath = _selectedImage?.path;
    if (date.isAfter(DateTime.now())) {
      AppDialogs.showWarningSnackBar(message: 'Date cannot be in the future');
      return;
    }
    if (weight <= 0) {
      AppDialogs.showWarningSnackBar(
        message: 'Weight must be greater than zero',
      );
      return;
    }

    if (_isEditMode && widget.entryId != null) {
      context.read<WeightFormCubit>().updateWeightEntry(
        entryId: widget.entryId!,
        weight: weight,
        date: date,
        progressPhotoPath: photoPath,
      );
    } else {
      context.read<WeightFormCubit>().saveWeightEntry(
        weight: weight,
        date: date,
        progressPhotoPath: photoPath,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return HideKeyboardOnTap(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        body: BlocListener<WeightFormCubit, WeightFormState>(
          listener: (context, state) {
            state.maybeWhen(
              saveSuccess: (message) {
                context.hideLoadingDialog();
                AppDialogs.showSuccessSnackBar(message: message);
                context.router.maybePop();
              },
              saveFailure: (errorMessage) {
                context.hideLoadingDialog();
                AppDialogs.showErrorSnackBar(message: errorMessage);
              },
              savingLoading: () {
                context.showLoadingDialog(
                  message: _isEditMode
                      ? 'Updating weight entry...'
                      : 'Saving weight entry...',
                  type: LoadingType.circular,
                );
              },
              orElse: () {},
            );
          },
          child: BlocBuilder<WeightFormCubit, WeightFormState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () {
                  return DataFetchLoadingWidget(
                    state: 'loading',
                    loadingMessage: 'Loading weight entry...',
                    loadingType: LoadingType.circular,
                  );
                },
                error: (message) {
                  return DataFetchLoadingWidget(
                    state: 'error',
                    errorMessage: message,
                    errorSubtitle: 'Please try again',
                    onRetry: () {
                      if (widget.entryId != null) {
                        context.read<WeightFormCubit>().loadWeightEntry(
                          entryId: widget.entryId!,
                        );
                      }
                    },
                  );
                },
                loaded: (weightEntry) {
                  // Load data only once when entry is first loaded
                  if (!_isDataLoaded) {
                    _weightController.text = weightEntry.weightKg.toString();
                    _selectedDate = weightEntry.recordedAt;
                    _imagePath = weightEntry.photoUrl;
                    _isDataLoaded = true;
                  }
                  return SafeArea(
                    child: Column(
                      children: [
                        // Header with back button and save button
                        WeightFormHeader(
                          onBack: () => context.router.maybePop(),
                          onSave: _onSave,
                          isEditMode: _isEditMode,
                        ),

                        // Form content
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 24.h),

                                  // Weight input field
                                  WeightInputField(
                                    controller: _weightController,
                                    onChanged: _onWeightChanged,
                                  ),

                                  SizedBox(height: 24.h),

                                  // Date selector
                                  DateSelectorField(
                                    selectedDate: _selectedDate,
                                    onDateChanged: _onDateChanged,
                                  ),

                                  SizedBox(height: 24.h),

                                  // Progress photo field (pass current selected path)
                                  ProgressPhotoField(
                                    onTap: _onProgressPhotoTap,
                                    photoPath: _selectedImage?.path,
                                  ),

                                  // Hiển thị ảnh lớn bên dưới khi đã chọn ảnh mới hoặc ảnh từ server
                                  if (_selectedImage != null ||
                                      _imagePath != null) ...[
                                    SizedBox(height: 16.h),
                                    Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 220.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16.r,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .shadow
                                                    .withValues(alpha: 0.08),
                                                blurRadius: 12,
                                                offset: Offset(0, 6),
                                              ),
                                            ],
                                            border: Border.all(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.outlineVariant,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              16.r,
                                            ),
                                            // Hiển thị ảnh mới được chọn hoặc ảnh từ server
                                            child: _selectedImage != null
                                                ? Image.file(
                                                    _selectedImage!,
                                                    key: ValueKey(
                                                      _selectedImage?.path,
                                                    ),
                                                    width: double.infinity,
                                                    height: 220.w,
                                                    fit: BoxFit.cover,
                                                  )
                                                : _imagePath != null
                                                ? Image.network(
                                                    _imagePath!,
                                                    width: double.infinity,
                                                    height: 220.w,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) => Container(
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .surfaceContainerHighest,
                                                          child: Icon(
                                                            Icons.broken_image,
                                                            size: 48.sp,
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .onSurfaceVariant,
                                                          ),
                                                        ),
                                                    loadingBuilder:
                                                        (
                                                          context,
                                                          child,
                                                          loadingProgress,
                                                        ) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 30.w,
                                                              height: 30.w,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                  )
                                                : Container(),
                                          ),
                                        ),
                                        Positioned(
                                          top: 12,
                                          right: 12,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedImage = null;
                                                  _imagePath = null;
                                                });
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                width: 38,
                                                height: 38,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.error,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.onError,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12.h),
                                    SizedBox(
                                      width: 150.w,
                                      child: OutlinedButton.icon(
                                        onPressed: _onProgressPhotoTap,
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                        label: Text(
                                          _selectedImage != null
                                              ? 'Change Photo'
                                              : 'Change Photo',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 24.h),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                orElse: () {
                  // When adding new entry (not in edit mode), show the form
                  if (!_isEditMode) {
                    return _buildWeightForm();
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWeightForm() {
    return SafeArea(
      child: Column(
        children: [
          // Header with back button and save button
          WeightFormHeader(
            onBack: () => context.router.maybePop(),
            onSave: _onSave,
            isEditMode: _isEditMode,
          ),

          // Form content
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 24.h),

                    // Weight input field
                    WeightInputField(
                      controller: _weightController,
                      onChanged: _onWeightChanged,
                    ),

                    SizedBox(height: 24.h),

                    // Date selector
                    DateSelectorField(
                      selectedDate: _selectedDate,
                      onDateChanged: _onDateChanged,
                    ),

                    SizedBox(height: 24.h),

                    // Progress photo field (pass current selected path)
                    ProgressPhotoField(
                      onTap: _onProgressPhotoTap,
                      photoPath: _selectedImage?.path,
                    ),

                    // Hiển thị ảnh lớn bên dưới khi đã chọn ảnh mới hoặc ảnh từ server
                    if (_selectedImage != null || _imagePath != null) ...[
                      SizedBox(height: 16.h),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 220.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.shadow.withValues(alpha: 0.08),
                                  blurRadius: 12,
                                  offset: Offset(0, 6),
                                ),
                              ],
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.outlineVariant,
                                width: 1.5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              // Hiển thị ảnh mới được chọn hoặc ảnh từ server
                              child: _selectedImage != null
                                  ? Image.file(
                                      _selectedImage!,
                                      key: ValueKey(_selectedImage?.path),
                                      width: double.infinity,
                                      height: 220.w,
                                      fit: BoxFit.cover,
                                    )
                                  : _imagePath != null
                                  ? Image.network(
                                      _imagePath!,
                                      width: double.infinity,
                                      height: 220.w,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surfaceContainerHighest,
                                                child: Icon(
                                                  Icons.broken_image,
                                                  size: 48.sp,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                              ),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: SizedBox(
                                                width: 30.w,
                                                height: 30.w,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                              ),
                                            );
                                          },
                                    )
                                  : Container(),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedImage = null;
                                    _imagePath = null;
                                  });
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.error,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onError,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: 150.w,
                        child: OutlinedButton.icon(
                          onPressed: _onProgressPhotoTap,
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          label: Text(
                            _selectedImage != null
                                ? 'Change Photo'
                                : 'Change Photo',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],

                    // Safe area bottom padding
                    SizedBox(height: MediaQuery.of(context).padding.bottom),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
