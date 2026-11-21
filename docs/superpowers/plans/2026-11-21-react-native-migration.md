# Kế hoạch chuyển Calorie Counter sang React Native

> Dùng skill superpowers:executing-plans hoặc superpowers:subagent-driven-development và đánh dấu từng bước sau khi kiểm tra.

**Mục tiêu**
Build React Native cho Android và iOS với đủ 13 nhóm tính năng của Flutter.

**Kiến trúc**
Đặt ứng dụng mới trong `mobile-rn/`. Flutter ở thư mục gốc là chuẩn đối chiếu. Dùng backend REST và Firebase hiện có. Tách tầng dùng chung cho phiên, ngày, dữ liệu API và tích hợp thiết bị khỏi các màn hình tính năng.

**Công nghệ**
TypeScript, Expo development build, Expo Router, TanStack Query, Expo SecureStore, React Native Firebase cho tích hợp native cần thiết, Jest với jest-expo và React Native Testing Library. Chọn phiên bản tương thích sau khi chốt mức iOS.

**Thiết kế**
[Bản thiết kế](../specs/2026-11-21-react-native-migration-design.md) · [Issue #1](https://github.com/solokill756/FE-calorie-counter/issues/1)

## Ràng buộc chung

- Giữ đủ 13 nhóm. Đối chiếu màn hình, dữ liệu, trạng thái tải, trống và lỗi với Flutter.
- Giữ tính logic dinh dưỡng ở backend. Giữ tên trường, đơn vị, định dạng ngày và cơ chế xác thực theo hợp đồng API.
- Android hiện dùng API 24 làm mức tối thiểu. Flutter khai báo iOS 15.0. Expo SDK 55 yêu cầu iOS 15.1 và Android API 24. SDK mới hơn trong bảng Expo có mức iOS 16.4. Ưu tiên SDK 55 nếu chấp nhận iOS 15.1 và các plugin native vượt qua kiểm tra tương thích. [Bảng phiên bản Expo](https://docs.expo.dev/versions/v55.0.0/)
- Dùng tài khoản và cấu hình được phép kiểm thử. Giá trị cấu hình môi trường không được đưa vào commit. Giữ build kiểm thử song song với Flutter bằng định danh phát triển riêng.
- Mỗi mốc bắt đầu bằng ca kiểm thử thất bại có chủ đích, sau đó triển khai, chạy lại ca kiểm thử và kiểm tra kiểu. Chỉ đánh dấu hoàn tất mốc sau khi lưu bằng chứng cần thiết.

## Các lỗi cần kiểm tra sớm

| Tình huống | Kết quả mong đợi | Mốc |
|---|---|---|
| Hai yêu cầu đồng thời hết hạn phiên | Một lần refresh, mỗi yêu cầu thử lại tối đa một lần | 1 |
| Chọn ngày gần nửa đêm hoặc trong múi giờ âm | Giữ đúng ngày địa phương khi tải và ghi | 2 |
| Ghi món thành công rồi đổi tab | Nhật ký và tổng quan cùng đọc dữ liệu mới | 2 |
| Từ chối quyền ảnh, hủy chọn hoặc upload lỗi | Không gửi URL rỗng, người dùng có thể thử lại | 3, 7 |
| Job AI hoàn thành khi app ở nền | Khôi phục đúng trạng thái khi quay lại, tránh báo trùng | 7, 8 |

### Task 1: Nền ứng dụng và phiên đăng nhập

**Tệp**
`mobile-rn/app.config.ts`, `mobile-rn/app/_layout.tsx`, `mobile-rn/app/(auth)/sign-in.tsx`, `mobile-rn/app/(tabs)/_layout.tsx`, `mobile-rn/src/lib/api-client.ts`, `mobile-rn/src/lib/session-store.ts`, `mobile-rn/src/features/account/api.ts`, `mobile-rn/src/lib/__tests__/api-client.test.ts`.

**Giao diện dùng chung**
`api.request<T>(path: string, options?: RequestOptions): Promise<T>` và `SessionStore.read/write/clear` với kiểu `Session` chứa access token và refresh token. Route quyết định từ phiên đã tải và trạng thái onboarding do API trả về.

- [ ] Khởi tạo Expo sau khi chốt tương thích, tạo cấu hình local và bản phát triển có ID riêng.
- [ ] Thêm kiểm thử tên `refreshes_once_for_concurrent_requests`, `stops_after_refresh_failure` và `restores_session_before_routing`. Xác nhận luồng chưa triển khai làm các test thất bại.
- [ ] Bám theo `auth_repository_impl.dart`, `auth_interceptor.dart` và `storage.dart` để nối `auth/login`, `auth/refresh`, `auth/me` và lưu token an toàn. Che token khỏi log. Dọn cache theo tài khoản khi đăng xuất.
- [ ] Chạy `npm test -- --runInBand api-client` và `npm run typecheck`. Kiểm tra mở lại app giữ phiên.
- [ ] Xác minh cấu hình Android/iOS, Firebase và nhà cung cấp đăng nhập cho định danh phát triển. Ghi commit cho nền ứng dụng.

### Task 2: Đăng nhập → Nhật ký → Ghi món → Tổng quan

**Tệp**
`mobile-rn/app/(tabs)/index.tsx`, `mobile-rn/app/(tabs)/diary.tsx`, `mobile-rn/app/food/search.tsx`, `mobile-rn/src/lib/local-date.ts`, `mobile-rn/src/features/diary/api.ts`, `mobile-rn/src/features/diary/__tests__/log-flow.test.tsx`.

**Giao diện**
`localDateKey(date: Date): string`, `getDiary(dateKey: string): Promise<Diary>`, `searchFoods(query: string): Promise<FoodPage>`, `logFood(input: FoodLogInput): Promise<void>` và `getDashboard(dateKey: string): Promise<Dashboard>`.

- [ ] Viết ca `preserves_selected_local_day` và `reloads_diary_and_dashboard_after_logging`. Kiểm tra API nhận đúng ngày và số lượng ở từng bữa, hai màn hình phản ánh lần ghi mới.
- [ ] Nối `GET api/Diary/{date}`, tìm kiếm `api/Food`, `POST api/LogFood` và `api/dashboard/today` theo các repository Dart. Kiểm tra khẩu phần, nhiều đơn vị và dữ liệu lỗi hoặc trống.
- [ ] Chạy `npm test -- --runInBand log-flow` và `npm run typecheck`. Thử cùng một tài khoản trên Flutter và RN, đối chiếu mục ghi và tổng calo.
- [ ] Ghi commit cho luồng xuyên suốt.

### Task 3: Hoàn tất tài khoản, hồ sơ và mục tiêu

**Tệp**
`mobile-rn/app/(auth)/`, `mobile-rn/app/(tabs)/more.tsx`, `mobile-rn/app/profile/`, `mobile-rn/src/features/account/api.ts`, `mobile-rn/src/features/profile/api.ts`, `mobile-rn/src/lib/media-upload.ts`, `mobile-rn/src/features/profile/__tests__/profile.test.tsx`.

**Giao diện**
`updateGoal(goalType: GoalType): Promise<UserProfile>`, `updateProfile(input: ProfilePatch): Promise<UserProfile>` và `uploadImage(input: ImageAsset, destination: UploadDestination): Promise<string>`.

- [ ] Viết ca `posts_supported_goal_slug_and_reloads_targets`, `skips_profile_patch_after_failed_upload` và `requires_confirmation_before_delete`.
- [ ] Nối đăng ký, onboarding và phục hồi mật khẩu theo `auth_repository_impl.dart` và `onboarding_repository_impl.dart`. Dùng Firebase để trao đổi token Google/Apple với backend theo nhánh nền tảng tương ứng.
- [ ] Nối `PATCH users/profile`, `PATCH users/goal` và `DELETE users/me`. Đối chiếu đủ tám lựa chọn, xử lý phản hồi lỗi và xóa phiên sau khi thao tác xóa thành công.
- [ ] Chạy `npm test -- --runInBand profile` và `npm run typecheck`. Thử Google/Apple, tải ảnh và xóa tài khoản thử có thể bỏ.
- [ ] Ghi commit cho tài khoản, hồ sơ và mục tiêu.

### Task 4: Hoàn tất nhật ký, thực phẩm và bữa ăn

**Tệp**
`mobile-rn/app/diary/`, `mobile-rn/app/food/`, `mobile-rn/app/meals/`, `mobile-rn/src/features/food/api.ts`, `mobile-rn/src/features/food/__tests__/meal-log.test.tsx`.

- [ ] Viết ca `keeps_serving_units_on_edit`, `removes_deleted_entry_from_both_views` và `logs_quick_calories_in_selected_meal`.
- [ ] Chuyển xem chi tiết, thêm/sửa/xóa mục nhật ký và ghi nhanh. Đối chiếu `diary_repository_impl.dart` và `logfood_repository_impl.dart` để giữ cấu trúc phần ăn, loại mục và giờ ghi.
- [ ] Chuyển thực phẩm và bữa ăn riêng qua `api/Food` và `api/Meal`, gồm danh sách gợi ý, thực phẩm gần đây, thêm/sửa/xóa và lưu lại để tái sử dụng theo Flutter.
- [ ] Chạy `npm test -- --runInBand meal-log` và `npm run typecheck`. So sánh trên cùng tài khoản và ghi commit.

### Task 5: Dinh dưỡng, nước và phần còn lại của Tổng quan

**Tệp**
`mobile-rn/app/nutrition/`, `mobile-rn/app/water.tsx`, `mobile-rn/src/features/nutrition/api.ts`, `mobile-rn/src/features/nutrition/export.ts`, `mobile-rn/src/features/water/api.ts`, `mobile-rn/src/features/nutrition/__tests__/nutrition-water.test.tsx`.

- [ ] Viết ca `exports_selected_range_with_escaped_csv_cells` và `updates_water_without_double_counting`.
- [ ] Chuyển báo cáo ngày/tuần, chi tiết dưỡng chất và chia sẻ CSV. Đối chiếu `api/Diary/range`, `api/LogFood` và `nutrition_csv_export_service.dart`.
- [ ] Chuyển API và giao diện nước theo `water_log_repository_impl.dart`. Nối lại thẻ tổng quan, lối tắt và gợi ý thông qua `api/dashboard/today/suggestion`.
- [ ] Chạy `npm test -- --runInBand nutrition-water` và `npm run typecheck`. Mở CSV từ màn hình chia sẻ và đối chiếu bản tổng quan sau khi ghi nước. Ghi commit.

### Task 6: Cân nặng, tiến độ và tập luyện

**Tệp**
`mobile-rn/app/(tabs)/progress.tsx`, `mobile-rn/app/weight/`, `mobile-rn/app/exercise/`, `mobile-rn/src/features/progress/api.ts`, `mobile-rn/src/features/exercise/api.ts`, `mobile-rn/src/features/progress/__tests__/progress-exercise.test.tsx`.

- [ ] Viết ca `renders_empty_and_single_weight_point` và `refreshes_exercise_summary_after_log_deletion`.
- [ ] Chuyển cân nặng và ảnh tiến độ, chỉnh sửa, biểu đồ và số đo mà bản Flutter đưa vào tiến độ. Nối `api/Weight`, `api/progress/trends` và các endpoint số đo trong `process_repo_impl.dart`.
- [ ] Chuyển danh mục bài tập, tạo/sửa/xóa bài tập riêng, ghi buổi tập và lịch sử qua `api/exercises` và `api/exercise-logs`.
- [ ] Chạy `npm test -- --runInBand progress-exercise` và `npm run typecheck`. So sánh lịch sử và biểu đồ giữa hai bản. Ghi commit.

### Task 7: Công thức AI và tủ thực phẩm

**Tệp**
`mobile-rn/app/recipes/`, `mobile-rn/app/pantry.tsx`, `mobile-rn/src/features/recipes/api.ts`, `mobile-rn/src/features/recipes/jobs.ts`, `mobile-rn/src/features/recipes/__tests__/recipe-jobs.test.tsx`.

- [ ] Viết ca `keeps_current_job_across_background_and_resume`, `sends_nothing_after_cancelled_image_picker` và `refreshes_pantry_after_item_removal`.
- [ ] Chuyển tạo công thức từ thực phẩm hoặc ảnh nguyên liệu. Dùng `food_repository_impl.dart` và `recipe_generation_coordinator.dart` để giữ hợp đồng tạo, lưu, chỉnh công thức, chuyển sang bữa ăn và cập nhật trạng thái.
- [ ] Chuyển `recipe-builder/staples` và luồng tạo kế hoạch, hạn mức và tùy chọn tự tạo đã có với `fridge-meal-plans`.
- [ ] Chạy `npm test -- --runInBand recipe-jobs` và `npm run typecheck`. Thử ảnh thật, mất mạng giữa chừng và phục hồi khi mở lại app. Ghi commit.

### Task 8: Thông báo và nghiệm thu Android/iOS

**Tệp**
`mobile-rn/app/notifications.tsx`, `mobile-rn/src/features/notifications/api.ts`, `mobile-rn/src/features/notifications/reminders.ts`, `mobile-rn/src/features/notifications/__tests__/reminders.test.ts`, `mobile-rn/README.md`.

- [ ] Viết ca `updates_unread_count_after_mark_read` và `does_not_duplicate_reminders_after_resume`. Kiểm tra app xử lý khi người dùng từ chối quyền.
- [ ] Chuyển danh sách và mở nội dung liên quan, đánh dấu đã đọc qua `api/notifications`. Lập lịch nhắc bữa và thông báo khi job AI sẵn sàng theo cách app Flutter thực sự dùng.
- [ ] Chạy `npm ci`, `npm run typecheck`, `npm test -- --runInBand`, và `npx expo export --platform all`. Chạy Expo Doctor và ghi kết quả.
- [ ] Tạo development build Android bằng `npx expo run:android` và iOS bằng `npx expo run:ios` trên macOS, hoặc dùng môi trường build đã được cấp quyền. Dùng công cụ build native thực tế để xác nhận hai bản cài được.
- [ ] Lưu kết quả đối chiếu cho 13 nhóm, các điều kiện thiết bị và ca lỗi. Chỉ kiểm thử cài đè Flutter khi đích phát hành yêu cầu. Ghi commit nghiệm thu và liên kết bằng chứng vào issue #1.
