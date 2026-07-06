import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'loading_widget.dart';

/// Widget tối ưu cho việc hiển thị trạng thái loading khi đang fetch dữ liệu từ server.
///
/// Hỗ trợ 3 trạng thái chính:
/// - **Loading**: Đang fetch dữ liệu từ server
/// - **Empty**: Không có dữ liệu
/// - **Error**: Lỗi khi fetch dữ liệu
/// - **Loaded**: Dữ liệu đã được load thành công
class DataFetchLoadingWidget extends StatelessWidget {
  /// Trạng thái của dữ liệu: 'loading', 'empty', 'error', 'loaded'
  final String state;

  /// Dữ liệu để hiển thị khi đã load thành công
  final Widget? loadedChild;

  /// Thông báo khi đang loading
  final String loadingMessage;

  /// Icon khi đang loading
  final LoadingType loadingType;

  /// Thông báo khi không có dữ liệu
  final String emptyMessage;

  /// Mô tả chi tiết khi không có dữ liệu
  final String? emptySubtitle;

  /// Icon hiển thị khi không có dữ liệu
  final IconData emptyIcon;

  /// Thông báo lỗi
  final String errorMessage;

  /// Mô tả chi tiết của lỗi
  final String? errorSubtitle;

  /// Callback khi nhấn nút Retry trong trạng thái error
  final VoidCallback? onRetry;

  /// Chiều cao tối thiểu của widget
  final double minHeight;

  /// Màu chủ đạo
  final Color? primaryColor;

  const DataFetchLoadingWidget({
    super.key,
    required this.state,
    this.loadedChild,
    this.loadingMessage = 'Loadding data...',
    this.loadingType = LoadingType.pulse,
    this.emptyMessage = 'No data available',
    this.emptySubtitle = 'Please try adding new data',
    this.emptyIcon = Icons.inbox,
    this.errorMessage = 'An error occurred',
    this.errorSubtitle = 'Please try again',
    this.onRetry,
    this.minHeight = 200,
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = primaryColor ?? Theme.of(context).primaryColor;

    switch (state.toLowerCase()) {
      case 'loading':
        return _buildLoadingState(color);

      case 'empty':
        return _buildEmptyState(color);

      case 'error':
        return _buildErrorState(color);

      case 'loaded':
        return loadedChild ?? const SizedBox.shrink();

      default:
        return const SizedBox.shrink();
    }
  }

  /// Xây dựng giao diện khi đang loading
  Widget _buildLoadingState(Color color) {
    return Container(
      constraints: BoxConstraints(minHeight: minHeight.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingWidget(
              message: loadingMessage,
              size: 48.0,
              type: loadingType,
              color: color,
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Please wait...',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Xây dựng giao diện khi không có dữ liệu
  Widget _buildEmptyState(Color color) {
    return Container(
      constraints: BoxConstraints(minHeight: minHeight.h),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!, width: 1.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(emptyIcon, size: 32.sp, color: color),
            ),
            SizedBox(height: 16.h),
            Text(
              emptyMessage,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            if (emptySubtitle != null && emptySubtitle!.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  emptySubtitle!,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Xây dựng giao diện khi có lỗi
  Widget _buildErrorState(Color color) {
    return Container(
      constraints: BoxConstraints(minHeight: minHeight.h),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.red[200]!, width: 1.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline, size: 32.sp, color: Colors.red),
            ),
            SizedBox(height: 16.h),
            Text(
              errorMessage,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red[900],
              ),
              textAlign: TextAlign.center,
            ),
            if (errorSubtitle != null && errorSubtitle!.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  errorSubtitle!,
                  style: TextStyle(fontSize: 13.sp, color: Colors.red[700]),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            SizedBox(height: 16.h),
            if (onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh, size: 18.sp),
                label: Text('Try Again', style: TextStyle(fontSize: 14.sp)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Widget helper cho việc xây dựng trạng thái loading dưới dạng sliver (cho CustomScrollView)
class SliverDataFetchLoadingWidget extends StatelessWidget {
  final String state;
  final Widget? loadedChild;
  final String loadingMessage;
  final LoadingType loadingType;
  final String emptyMessage;
  final String? emptySubtitle;
  final String errorMessage;
  final String? errorSubtitle;
  final VoidCallback? onRetry;
  final double minHeight;
  final Color? primaryColor;

  const SliverDataFetchLoadingWidget({
    super.key,
    required this.state,
    this.loadedChild,
    this.loadingMessage = 'Loading data...',
    this.loadingType = LoadingType.pulse,
    this.emptyMessage = 'No data available',
    this.emptySubtitle = 'Please try adding new data',
    this.errorMessage = 'An error occurred',
    this.errorSubtitle = 'Please try again',
    this.onRetry,
    this.minHeight = 200,
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    if (state.toLowerCase() == 'loaded' && loadedChild != null) {
      return SliverToBoxAdapter(child: loadedChild!);
    }

    return SliverToBoxAdapter(
      child: DataFetchLoadingWidget(
        state: state,
        loadingMessage: loadingMessage,
        loadingType: loadingType,
        emptyMessage: emptyMessage,
        emptySubtitle: emptySubtitle,
        errorMessage: errorMessage,
        errorSubtitle: errorSubtitle,
        onRetry: onRetry,
        minHeight: minHeight,
        primaryColor: primaryColor,
      ),
    );
  }
}
