# Chuyển Calorie Counter sang React Native

Theo dõi công việc tại [GitHub issue #1](https://github.com/solokill756/FE-calorie-counter/issues/1).

## Mục tiêu

Chuyển ứng dụng Android và iOS sang React Native, giữ đủ 13 nhóm tính năng đang hoạt động. Dùng bản Flutter làm chuẩn đối chiếu hành vi. Bản React Native dùng API và Firebase hiện có để người dùng truy cập cùng tài khoản và dữ liệu trên máy chủ. Công thức tính mục tiêu calo và macro tiếp tục chạy trên backend.

## Phương án

Người dùng chọn đặt React Native trong cùng repo. Tạo `mobile-rn/` với TypeScript và Expo development build, giữ Flutter ở thư mục gốc để hai bản chạy song song. Cấu hình build React Native nằm trong `mobile-rn/`. Repo riêng sẽ tách lịch sử và quy trình build ngay từ đầu, đồng thời cần phối hợp thay đổi API, tài liệu và kiểm thử giữa hai repo.

## Phạm vi chức năng

| Nhóm | Hành vi cần đối chiếu |
|---|---|
| 1. Tài khoản | Đăng ký, thiết lập ban đầu, đăng nhập email/Google/Apple theo nền tảng, khôi phục mật khẩu, đăng xuất, khôi phục phiên và xóa tài khoản có bước xác nhận |
| 2. Hồ sơ cá nhân | Xem, sửa thông tin và tải ảnh đại diện |
| 3. Mục tiêu | Chọn một trong tám mục tiêu chính, lưu qua API và tải lại chỉ tiêu liên quan |
| 4. Tổng quan | Xem calo và hoạt động trong ngày, truy cập nhật ký và các thao tác ghi nhanh |
| 5. Nhật ký ăn uống | Xem theo ngày và bữa, thêm, sửa và xóa mục đã ghi theo khả năng của Flutter |
| 6. Thực phẩm và bữa ăn | Tìm kiếm, xem chi tiết, tạo và sửa thực phẩm hoặc bữa ăn đã lưu, nhập nhanh calo |
| 7. Dinh dưỡng | Xem báo cáo ngày và tuần, calo, macro, dưỡng chất chi tiết và xuất CSV |
| 8. Nước uống | Xem và ghi lượng nước theo ngày |
| 9. Cân nặng | Ghi cân nặng, ảnh tiến độ và xem biểu đồ |
| 10. Tập luyện | Duyệt danh mục, quản lý bài tập riêng, ghi buổi tập và xem lịch sử |
| 11. Công thức AI | Gợi ý từ thực phẩm hoặc ảnh nguyên liệu, theo dõi tiến trình và lưu công thức theo luồng hiện có |
| 12. Tủ thực phẩm | Quản lý nguyên liệu có sẵn và sử dụng chúng trong các luồng công thức hiện có |
| 13. Thông báo | Xem, đánh dấu đã đọc và mở nội dung liên quan. Duy trì lịch nhắc ghi bữa và thông báo cục bộ khi công thức AI sẵn sàng |

Flutter là chuẩn đối chiếu về thao tác, dữ liệu đầu vào, kết quả và các trạng thái tải, trống, lỗi. Giao diện giữ cấu trúc điều hướng và thông tin hiện có, có thể dùng thành phần phù hợp với Android và iOS. Quét mã vạch, ghi bằng giọng nói và quét ảnh bữa ăn đang là nút giữ chỗ, nằm ngoài phạm vi. Phạm vi build gồm Android và iOS.

## Kiến trúc và thứ tự chuyển

1. Tạo nền React Native, điều hướng, cấu hình môi trường, API client có kiểu dữ liệu và lưu trữ phiên an toàn. Xác minh Expo development build truy cập được các tích hợp cần thiết trên mỗi nền tảng.
2. Hoàn thành luồng đăng nhập, mở nhật ký, tìm và ghi món, rồi kiểm tra tổng quan cập nhật. Dùng cùng một tài khoản thử nghiệm để kiểm tra Flutter và React Native nhìn thấy cùng dữ liệu. Giữ đúng ngày ghi theo múi giờ và cơ chế làm mới phiên của API.
3. Chuyển các nhóm còn lại theo bảng. Kiểm tra sớm đăng nhập Google/Apple, thư viện ảnh và camera, tải ảnh qua Firebase, thông báo cục bộ, chia sẻ CSV và trạng thái công thức AI khi ứng dụng chuyển nền. Đối chiếu việc làm mới dữ liệu sau mỗi thao tác ghi ở các màn hình có liên quan.
4. Kiểm thử trên Android và iOS, đối chiếu từng nhóm trước khi coi bản React Native đủ tính năng. Dùng backend và Firebase được phép chạy kiểm thử tích hợp. Chứng minh đăng nhập Google/Apple truy cập cùng tài khoản backend trên hai bản. Chỉ kiểm thử xóa với tài khoản dùng một lần.

Mã RN dùng bộ quản lý dữ liệu API để làm mới các màn hình dùng chung dữ liệu, lưu thông tin xác thực trong kho bảo mật của hệ điều hành và lưu tùy chọn cục bộ riêng. Gói điều hướng, biểu đồ và cách chia module là quyết định của người triển khai, dựa trên khả năng hỗ trợ cả hai nền tảng. Kiểm kê hợp đồng từ các service và interceptor Dart theo từng nhóm để giữ đúng cách xử lý token, lỗi API, ngày và đơn vị.

## Build và nâng cấp

Bản phát triển dùng định danh riêng khi cần cài cùng Flutter trên một thiết bị. Kiểm kê cấu hình backend, Firebase và nhà cung cấp đăng nhập cho từng định danh ở mốc nền tảng. Kiểm thử API có thể bắt đầu bằng backend chạy cục bộ trong lúc chuẩn bị cấu hình đăng nhập và thiết bị thử. Mốc hoàn thành chuyển đổi yêu cầu build Android và iOS cùng bằng chứng kiểm thử cho cả 13 nhóm. Build iOS cần môi trường macOS hoặc dịch vụ build đã được cấp quyền. Phát hành lên cửa hàng là quyết định riêng.

Mặc định ưu tiên giữ phiên bản hệ điều hành tối thiểu của Flutter, gồm iOS 15.0 và mức Android do cấu hình Flutter hiện tại xác định. Đối chiếu yêu cầu của Expo và các dependency native trước khi khóa phiên bản. Mọi thay đổi về mức hỗ trợ thiết bị sẽ được đưa ra duyệt trước khi chọn cấu hình làm thay đổi mức hỗ trợ đó.

Nếu React Native sẽ được phát hành đè lên bản Flutter, bổ sung kiểm thử cài đè trước phát hành với cùng định danh ứng dụng và cấu hình ký phù hợp. Kiểm kê dữ liệu Flutter lưu trong secure storage và shared preferences, gồm token, mã thiết bị và tùy chọn tự tạo kế hoạch công thức. Kiểm tra phục hồi phiên, dữ liệu cục bộ và lịch thông báo khi nâng cấp. Nếu phiên cũ không thể chuyển an toàn trên một nền tảng, đưa hành vi đăng nhập lại ra duyệt trước khi phát hành bản cập nhật.
