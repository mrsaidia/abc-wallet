# ABC Wallet

ABC Wallet là một ứng dụng ví blockchain hỗ trợ người dùng quản lý và giao dịch token một cách dễ dàng và an toàn. Ứng dụng cung cấp các chức năng cơ bản của một ví blockchain, bao gồm tạo và quản lý ví, xem seedphrase hoặc private key, nhập mạng, và thực hiện các giao dịch token trên mạng thử nghiệm (test net).

## Bắt đầu

1. [Tải Xcode](https://developer.apple.com/download/more/). Kiểm tra phiên bản Xcode mà chúng tôi đang sử dụng [tại đây](.xcode-version).
2. Clone repository này.
3. Chạy lệnh `make bootstrap` để cài đặt các công cụ và dependencies.
4. Mở file `.xcworkspace` (không phải `.xcodeproj`) để bắt đầu.

Nếu bạn gặp lỗi "Bundle does not exist. Please install bundle.", vui lòng tham khảo với chuyên gia macOS vì một phần quan trọng của hệ thống của bạn đang thiếu.

Makefile này đã được kiểm tra để chạy trên "Monterey"-12.0.1. Nó sẽ không hoạt động trên "Catalina" hoặc "Big Sur".


### Cập nhật GemFile hoặc Podfile

Sau khi cập nhật Gemfile, chạy `make install_gems` để cập nhật các gems trong thư mục vendor/bundle.

Sau khi cập nhật Podfile, chạy `make install_pods` để cập nhật các pods trong thư mục Pods.


## Tính năng

- **Import/Create ví**: Người dùng có thể tạo một ví mới hoặc nhập một ví hiện có.
- **Tạo/Xem Seedphrase hoặc Private Key**: ABC Wallet cho phép người dùng tạo và hiển thị seedphrase hoặc private key của ví.
- **Import Network**: Người dùng có thể thêm và quản lý các mạng blockchain khác nhau.
- **Chuyển/Nhận Token (Test Net)**: Thực hiện các giao dịch chuyển và nhận token trên mạng thử nghiệm.
- **Xem Transaction**: Hiển thị lịch sử giao dịch của ví.


## Hướng dẫn sử dụng

1. **Tạo/Import ví**:
   - Mở ứng dụng và chọn "Tạo ví mới" hoặc "Import ví".
   - Nếu chọn "Import ví", nhập seedphrase hoặc private key của ví hiện có.

2. **Xem Seedphrase/Private Key**:
   - Trong phần quản lý ví, chọn "Xem Seedphrase" hoặc "Xem Private Key" để hiển thị thông tin bảo mật.

3. **Thêm mạng**:
   - Đi đến phần "Quản lý mạng" và thêm các mạng blockchain mà bạn muốn kết nối.

4. **Chuyển/Nhận token**:
   - Để chuyển token, chọn "Chuyển token", nhập địa chỉ người nhận và số lượng token.
   - Để nhận token, cung cấp địa chỉ ví của bạn cho người gửi.

5. **Xem lịch sử giao dịch**:
   - Trong phần "Lịch sử giao dịch", bạn có thể xem các giao dịch đã thực hiện.

## Đóng góp

Chúng tôi hoan nghênh mọi đóng góp cho dự án này. Vui lòng tạo pull request hoặc mở issue nếu bạn có bất kỳ đề xuất hoặc gặp vấn đề nào.

## Giấy phép

ABC Wallet được phát hành dưới giấy phép MIT. Vui lòng xem file LICENSE để biết thêm chi tiết.

---

Nếu bạn có bất kỳ câu hỏi hoặc cần hỗ trợ, vui lòng liên hệ với chúng tôi qua email: 20520318@gm.uit.edu.vn

