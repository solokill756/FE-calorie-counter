# Hướng dẫn sử dụng ErrorWidgetCustom

## 📦 File: `error_widget_custom.dart`

Có 2 widget để hiển thị lỗi:

---

## 1️⃣ `ErrorWidgetCustom` - Full Screen Error

Hiển thị lỗi toàn màn hình với icon, tiêu đề, tin nhắn, và nút Retry.

### Import

```dart
import '../../common/widgets/error_widget_custom.dart';
```

### Cách 1: Sử dụng trong BlocBuilder

```dart
body: BlocBuilder<ProgressCubit, ProgressState>(
  builder: (context, state) {
    return state.maybeWhen(
      // Khi đang loading
      loading: () => const Center(child: CircularProgressIndicator()),

      // Khi load thành công
      loaded: (stats) => SingleChildScrollView(
        child: Column(
          children: [
            // Your UI here
          ],
        ),
      ),

      // Khi có lỗi
      error: (message) => ErrorWidgetCustom(
        title: 'Oops!',
        message: message,
        icon: Icons.error_outline,
        onRetry: () => context.read<ProgressCubit>().fetchProgress(),
        showRetryButton: true,
      ),

      orElse: () => const SizedBox.shrink(),
    );
  },
)
```

### Cách 2: Sử dụng khi gọi API

```dart
try {
  final result = await repository.fetchData();
  // Handle success
} catch (e) {
  showDialog(
    context: context,
    builder: (context) => ErrorWidgetCustom(
      title: 'Loading Failed',
      message: e.toString(),
      onRetry: () => _retryLoading(),
    ),
  );
}
```

### Parameters

| Parameter         | Type          | Required | Mô tả                                            |
| ----------------- | ------------- | -------- | ------------------------------------------------ |
| `message`         | String?       | ❌       | Tin nhắn lỗi (default: "Failed to load data...") |
| `title`           | String?       | ❌       | Tiêu đề (default: "Oops! Something went wrong")  |
| `onRetry`         | VoidCallback? | ❌       | Callback khi click Retry                         |
| `icon`            | IconData      | ❌       | Icon hiển thị (default: Icons.error_outline)     |
| `showRetryButton` | bool          | ❌       | Hiển thị nút Retry (default: true)               |

### Ví dụ:

```dart
ErrorWidgetCustom(
  message: 'Không thể tải dữ liệu cân nặng. Kiểm tra kết nối mạng.',
  title: 'Lỗi Kết Nối',
  icon: Icons.cloud_off,
  onRetry: () => context.read<ProgressCubit>().fetchProgress(),
  showRetryButton: true,
)
```

---

## 2️⃣ `ErrorDialog` - Dialog Error

Hiển thị lỗi trong một dialog alert.

### Cách sử dụng

```dart
showDialog(
  context: context,
  builder: (context) => ErrorDialog(
    message: 'Failed to load progress data',
    title: 'Error',
    onRetry: () => context.read<ProgressCubit>().fetchProgress(),
  ),
);
```

### Parameters

| Parameter | Type          | Required | Mô tả                             |
| --------- | ------------- | -------- | --------------------------------- |
| `message` | String        | ✅       | Tin nhắn lỗi                      |
| `title`   | String?       | ❌       | Tiêu đề dialog (default: "Error") |
| `onRetry` | VoidCallback? | ❌       | Callback cho nút Retry            |

### Ví dụ:

```dart
if (state is ProgressError) {
  showDialog(
    context: context,
    builder: (context) => ErrorDialog(
      message: state.message,
      title: 'Loading Failed',
      onRetry: () {
        Navigator.pop(context);
        context.read<ProgressCubit>().fetchProgress();
      },
    ),
  );
}
```

---

## 📋 Sử dụng trong ProgressPage

Đã được implement sẵn:

```dart
BlocListener<ProgressCubit, ProgressState>(
  listener: (context, state) {
    state.maybeWhen(
      loading: () {
        // Hiển thị loading dialog
        context.showLoadingDialog(
          message: 'Loading progress data...',
          type: LoadingType.circular,
        );
      },
      loaded: (stats) {
        context.hideLoadingDialog();
        setState(() {
          _entries = stats.entries;
        });
      },
      error: (message) {
        context.hideLoadingDialog();
        // Hiển thị error dialog
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(
            message: message,
            title: 'Error',
            onRetry: () => context.read<ProgressCubit>().fetchProgress(),
          ),
        );
      },
      orElse: () {},
    );
  },
  child: // UI content
)
```

---

## 🎨 Styling

### Full Screen Error (ErrorWidgetCustom)

- **Background**: Màu xám nhạt
- **Icon circle**: Nền đỏ nhạt, icon đỏ
- **Title**: Size 18sp, bold, đen
- **Message**: Size 14sp, màu xám
- **Button**: Nền đỏ, text trắng, border-radius 8r

### Dialog Error (ErrorDialog)

- **Background**: Trắng
- **Border Radius**: 16r
- **Title**: Icon + Text (đỏ + bold)
- **Content**: Màu xám 700
- **Buttons**: Retry (xanh) + Close (xám)

---

## ⚙️ Responsive Design

Cả 2 widget đều sử dụng `flutter_screenutil` để responsive:

- `.w` - width units
- `.h` - height units
- `.sp` - font size units
- `.r` - border radius units

Vd: `EdgeInsets.all(24.w)` sẽ tự scale theo screen size

---

## 🔄 Flow Diagram

```
Loading Data
    ↓
    ├─ Success → ErrorWidgetCustom HIDDEN
    │             Content SHOWN
    │
    └─ Error → ErrorWidgetCustom SHOWN
               hoặc ErrorDialog SHOWN
               Nút Retry call onRetry callback
```

---

## ✅ Checklist sử dụng

- [x] Import `error_widget_custom.dart`
- [x] Wrap content với `BlocListener` hoặc `BlocBuilder`
- [x] Handle `error` state với `ErrorWidgetCustom` hoặc `ErrorDialog`
- [x] Pass `onRetry` callback để retry
- [x] Test lỗi bằng cách:
  - Tắt internet
  - Fake lỗi API
  - Kiểm tra hiển thị error

---

## 🐛 Troubleshooting

**Q: ErrorWidgetCustom không hiển thị?**

- A: Kiểm tra state có trả về `error` không
- Kiểm tra import đúng chưa

**Q: Nút Retry không hoạt động?**

- A: Kiểm tra `onRetry` callback có được pass không
- Kiểm tra `context.read<ProgressCubit>()` có instance không

**Q: Text bị cắt?**

- A: Dùng `ErrorWidgetCustom` thay vì `ErrorDialog` (full screen)

---

## 📚 Ví dụ hoàn chỉnh

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/widgets/error_widget_custom.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyCubit, MyState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (data) => MyContent(data: data),
            error: (message) => ErrorWidgetCustom(
              title: 'Lỗi tải dữ liệu',
              message: message,
              icon: Icons.cloud_off,
              onRetry: () => context.read<MyCubit>().fetch(),
            ),
            orElse: () => SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
```

---

**Tất cả đã sẵn sàng! 🚀**
