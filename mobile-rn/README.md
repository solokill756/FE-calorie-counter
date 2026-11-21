# Calorie Counter RN

Ứng dụng React Native thử nghiệm nằm trong cùng repo với Flutter.

## Chạy bản phát triển

Cài dependencies bằng `npm ci`. Sao chép `.env.example` thành `.env.local` và đặt `EXPO_PUBLIC_API_URL` trỏ đến backend kiểm thử. Biến này xuất hiện trong bundle ứng dụng nên chỉ đặt URL công khai. Dùng `npm run android` trên máy có Android SDK. Dùng `npm run ios` trên macOS có Xcode.

Sau khi cài APK debug hoặc development build, chạy `npm start` để mở Metro. Chọn máy chủ Metro có thể truy cập được từ thiết bị hoặc emulator. ID phát triển là `com.trietngan.caloriecounter.rn`.

## Kiểm tra mã

Chạy `npm run typecheck`, `npm run lint` và `npm test -- --runInBand` từ thư mục này.

## Firebase và đăng nhập liên kết

Đăng ký định danh phát triển `com.trietngan.caloriecounter.rn` trong dự án Firebase dùng để kiểm thử. Đặt đường dẫn tương đối hoặc tuyệt đối tới tệp Google Services của từng nền tảng trong `.env.local`. Cấu hình SHA của bản ký Android, OAuth web client ID và reversed client ID iOS cho Google. Bật Sign in with Apple cho định danh iOS trước khi đặt `EXPO_PUBLIC_APPLE_SIGN_IN=1`. Sau khi thay đổi cấu hình native, tạo lại development build. Giữ tệp cấu hình tách khỏi repo.

## Kiểm thử với backend cục bộ

Chạy `CALORIE_TEST_API_URL=http://127.0.0.1:3001 npm test -- --runInBand local-backend` khi backend phát triển chạy ở cổng 3001. Ca này tạo một tài khoản dùng một lần, thực hiện các thao tác ghi rồi xóa tài khoản đó. Android Emulator thường dùng `http://10.0.2.2:3001` để truy cập backend trên máy chạy emulator. Khi backend chạy trong WSL và emulator chạy trên Windows, dùng địa chỉ IP của WSL nếu cổng backend không truy cập được qua `10.0.2.2`. iOS Simulator trên máy cùng backend dùng `http://127.0.0.1:3001`.

Việc nhận token đặt lại mật khẩu ở môi trường sản xuất phụ thuộc cơ chế gửi token của backend. Job AI dùng HTTP đồng bộ. App lưu bản nháp sau khi nhận kết quả và có thể mở lại bản nháp để lưu. Khi hệ điều hành đóng app trước lúc tải được kết quả, app cho phép bắt đầu lại.
