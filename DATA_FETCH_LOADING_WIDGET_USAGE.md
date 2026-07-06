# DataFetchLoadingWidget - Hướng dẫn sử dụng

## Giới thiệu

`DataFetchLoadingWidget` là một widget toàn diện để quản lý trạng thái loading khi fetch dữ liệu từ server. Nó hỗ trợ 4 trạng thái chính:

- **loading**: Đang fetch dữ liệu
- **empty**: Không có dữ liệu
- **error**: Lỗi khi fetch
- **loaded**: Dữ liệu đã load thành công

## Cách sử dụng cơ bản

```dart
DataFetchLoadingWidget(
  state: _state, // 'loading', 'empty', 'error', 'loaded'
  loadedChild: _yourDataWidget,
  loadingMessage: 'Đang tải dữ liệu...',
  onRetry: () => _fetchData(),
)
```

## Các tham số

| Tham số          | Loại          | Bắt buộc | Mô tả                                                        |
| ---------------- | ------------- | -------- | ------------------------------------------------------------ |
| `state`          | String        | ✅       | Trạng thái hiện tại: 'loading', 'empty', 'error', 'loaded'   |
| `loadedChild`    | Widget?       | ❌       | Widget hiển thị khi dữ liệu đã load                          |
| `loadingMessage` | String        | ❌       | Thông báo khi đang loading (mặc định: 'Đang tải dữ liệu...') |
| `loadingType`    | LoadingType   | ❌       | Kiểu animation loading (mặc định: pulse)                     |
| `emptyMessage`   | String        | ❌       | Thông báo khi không có dữ liệu                               |
| `emptySubtitle`  | String?       | ❌       | Mô tả chi tiết khi trống                                     |
| `emptyIcon`      | IconData      | ❌       | Icon khi trống (mặc định: Icons.inbox)                       |
| `errorMessage`   | String        | ❌       | Thông báo lỗi                                                |
| `errorSubtitle`  | String?       | ❌       | Mô tả chi tiết của lỗi                                       |
| `onRetry`        | VoidCallback? | ❌       | Callback khi nhấn nút Retry                                  |
| `minHeight`      | double        | ❌       | Chiều cao tối thiểu (mặc định: 200)                          |
| `primaryColor`   | Color?        | ❌       | Màu chủ đạo (mặc định: theme primaryColor)                   |

## Ví dụ 1: Sử dụng trong WeightFormPage

```dart
class _WeightFormViewState extends State<WeightFormView> {
  String _dataState = 'loading';
  WeightFormModel? _editingData;

  @override
  void initState() {
    super.initState();
    if (widget.entryId != null) {
      _loadEntryData();
    } else {
      _dataState = 'loaded';
    }
  }

  void _loadEntryData() async {
    try {
      final data = await _repository.getWeightEntry(widget.entryId!);
      setState(() {
        _editingData = data;
        _dataState = 'loaded';
      });
    } catch (e) {
      setState(() {
        _dataState = 'error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DataFetchLoadingWidget(
      state: _dataState,
      loadingMessage: 'Đang tải dữ liệu entry...',
      errorMessage: 'Không thể tải dữ liệu',
      errorSubtitle: 'Vui lòng kiểm tra kết nối internet',
      onRetry: _loadEntryData,
      loadedChild: _buildFormContent(),
    );
  }

  Widget _buildFormContent() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          // Form fields
        ],
      ),
    );
  }
}
```

## Ví dụ 2: Sử dụng trong ProgressPage

```dart
class _ProgressPageState extends State<ProgressPage> {
  String _entriesState = 'loading';
  List<ProgressEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() async {
    try {
      final entries = await _repository.getProgressEntries();
      setState(() {
        _entries = entries;
        _entriesState = entries.isEmpty ? 'empty' : 'loaded';
      });
    } catch (e) {
      setState(() {
        _entriesState = 'error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DataFetchLoadingWidget(
      state: _entriesState,
      loadingMessage: 'Đang tải entries...',
      emptyMessage: 'Chưa có entries nào',
      emptySubtitle: 'Hãy thêm entry đầu tiên',
      errorMessage: 'Không thể tải entries',
      onRetry: _loadEntries,
      loadedChild: _buildEntriesList(),
    );
  }

  Widget _buildEntriesList() {
    return ListView.builder(
      itemCount: _entries.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_entries[index].toString()),
        );
      },
    );
  }
}
```

## Ví dụ 3: Sử dụng với BLoC

```dart
@override
Widget build(BuildContext context) {
  return BlocBuilder<ProgressCubit, ProgressState>(
    builder: (context, state) {
      return state.maybeWhen(
        loading: () => DataFetchLoadingWidget(state: 'loading'),
        loaded: (stats) => DataFetchLoadingWidget(
          state: 'loaded',
          loadedChild: _buildProgressContent(stats),
        ),
        error: (message) => DataFetchLoadingWidget(
          state: 'error',
          errorMessage: message,
          onRetry: () => context.read<ProgressCubit>().loadProgressData(),
        ),
        orElse: () => const SizedBox.shrink(),
      );
    },
  );
}
```

## Kiểu Loading Animations

`DataFetchLoadingWidget` hỗ trợ 6 kiểu animation loading:

- `LoadingType.circular` - Vòng tròn quay
- `LoadingType.dots` - Ba chấm nhảy
- `LoadingType.pulse` - Xung nhịp (mặc định)
- `LoadingType.spinner` - Quay xoay
- `LoadingType.wave` - Sóng
- `LoadingType.gear` - Bánh răng

```dart
DataFetchLoadingWidget(
  state: 'loading',
  loadingType: LoadingType.wave, // Thay đổi kiểu animation
)
```

## Sử dụng với CustomScrollView (Sliver)

Nếu cần sử dụng trong `CustomScrollView`, hãy dùng `SliverDataFetchLoadingWidget`:

```dart
CustomScrollView(
  slivers: [
    SliverAppBar(
      title: Text('Dữ liệu'),
    ),
    SliverDataFetchLoadingWidget(
      state: _state,
      loadedChild: SliverList(...),
    ),
  ],
)
```

## Tùy chỉnh màu sắc

```dart
DataFetchLoadingWidget(
  state: _state,
  primaryColor: Colors.blue, // Tùy chỉnh màu chủ đạo
  loadedChild: _content,
)
```

## Tips & Tricks

### 1. Tích hợp với BLoC State

```dart
BlocBuilder<MyDataCubit, MyDataState>(
  builder: (context, state) {
    return state.map(
      initial: (_) => DataFetchLoadingWidget(state: 'loading'),
      loading: (_) => DataFetchLoadingWidget(state: 'loading'),
      loaded: (data) => DataFetchLoadingWidget(
        state: data.items.isEmpty ? 'empty' : 'loaded',
        loadedChild: _buildList(data.items),
      ),
      error: (error) => DataFetchLoadingWidget(
        state: 'error',
        errorMessage: error.message,
        onRetry: () => context.read<MyDataCubit>().fetch(),
      ),
    );
  },
)
```

### 2. Thêm Padding/Margin

```dart
Padding(
  padding: EdgeInsets.all(16.w),
  child: DataFetchLoadingWidget(
    state: _state,
    minHeight: 300.h,
    loadedChild: _content,
  ),
)
```

### 3. Responsive Height

```dart
DataFetchLoadingWidget(
  state: _state,
  minHeight: MediaQuery.of(context).size.height * 0.6,
  loadedChild: _content,
)
```

## Trạng thái chuyển đổi

```dart
// Khởi tạo
_state = 'loading';

// Khi fetch thành công
setState(() => _state = 'loaded');

// Khi fetch không có dữ liệu
setState(() => _state = 'empty');

// Khi fetch lỗi
setState(() => _state = 'error');
```

## Liên kết với các widget khác

- Sử dụng cùng `LoadingWidget` cho custom loading screens
- Tương thích với `LoadingButton` cho retry buttons
- Có thể kết hợp với `LoadingOverlay` cho overlay effects
