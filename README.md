# 🏥 Hospital Frenzy: Game Performance & Monetization Strategy

![Status](https://img.shields.io/badge/Status-Completed-success)
![Tools](https://img.shields.io/badge/Tools-BigQuery%20%7C%20PowerBI%20%7C%20SQL-blue)

## 📌 1. Executive Summary (Tóm tắt dự án)
**Hospital Frenzy** là tựa game quản lý thời gian (Time Management) với mô hình kiếm tiền lai (Hybrid Monetization: IAP + IAA). Mặc dù có lượng người chơi ổn định (**73k Active Users**), dự án gặp vấn đề lớn về chuyển đổi doanh thu với **Buyer Rate chỉ đạt 0.1%** và tỷ lệ giữ chân ngày đầu (Retention D1) thấp (**13.6%**).

Dự án này sử dụng SQL (BigQuery) để xử lý dữ liệu thô và Power BI để xây dựng Dashboard, nhằm mục đích:
1.  Tìm ra nguyên nhân người dùng rời bỏ game (Drop-off points).
2.  Phân khúc khách hàng (Segmentation) để tối ưu doanh thu.
3.  Đề xuất chiến lược cải thiện sản phẩm và marketing.

---

## 🛠 2. Tech Stack (Công nghệ sử dụng)
* **Google BigQuery (SQL):**
    * ETL Pipeline: Hợp nhất dữ liệu từ 3 nguồn (Gameplay, IAP, Ads).
    * Data Cleaning: Xử lý `user_id` rác, chuẩn hóa định dạng ngày tháng.
    * Advanced Analytics: Sử dụng `Window Functions` để tính Cohort Retention và tái tạo logic `Install Date`.
* **Power BI:**
    * Data Modeling: Xây dựng mô hình Star Schema.
    * DAX Measures: Tính toán ARPU, ARPPU, Conversion Rate theo thời gian thực.
    * Visualization: 4 trang báo cáo tương tác (Overview, Finance, Journey, Segmentation).

---

## 📊 3. Key Analysis & Insights (Phân tích chính)

### A. The "Kill Zone" at Level 12 (Cửa tử tại Level 12)
Dữ liệu hành trình khách hàng chỉ ra một điểm gãy (drop-off) nghiêm trọng:
* **40% User** rời bỏ game trong khoảng từ Tutorial đến Level 12 (~10 phút chơi đầu tiên).
* **Nguyên nhân:** Độ khó tăng đột ngột (Difficulty Spike) tại Level 12 yêu cầu nâng cấp thiết bị, nhưng user thiếu tài nguyên (Coins).
* 👉 *Đây là nguyên nhân chính dẫn đến Retention D1 thấp.*

### B. Monetization Paradox (Nghịch lý doanh thu)
* **Buyer Rate (0.1%):** Cực thấp. Chỉ có ~136 người nạp tiền thật (IAP).
* **High Value Users (~7,700):** Khi phân tích RFM kết hợp doanh thu quảng cáo (IAA), phát hiện ra một nhóm lớn user không nạp tiền nhưng xem rất nhiều quảng cáo.
* 👉 *Cần chiến lược riêng cho nhóm "Cày chay xem ads" này.*

---

## 💡 4. Recommendations (Đề xuất chiến lược)

Dựa trên dữ liệu, tôi đề xuất kế hoạch hành động 3 điểm:

| Mức độ | Vấn đề | Giải pháp đề xuất |
| :--- | :--- | :--- |
| **KHẨN CẤP** | **Drop-rate 40% tại Level 12** | **Cân bằng Game:** Giảm độ khó Level 12 hoặc tặng "Quà mồi" (Seed Money) trước khi vào màn chơi để hỗ trợ user nâng cấp. |
| **QUAN TRỌNG** | **Chuyển đổi IAP thấp (0.1%)** | **Starter Pack $0.99:** Tung gói ưu đãi giá rẻ xuất hiện khi user thua cuộc (Loss aversion) để kích thích lần thanh toán đầu tiên. |
| **CHIẾN LƯỢC** | **Big Spenders có dấu hiệu rời bỏ** | **RFM Marketing:** Gửi quà tri ân và thông báo cá nhân hóa (Push Notification) cho 5,000 user nhóm Big Spenders có R-Score thấp. |

---

## 📂 5. Project Structure (Cấu trúc thư mục)
* `01_SQL_Processing/`: Mã nguồn SQL xử lý làm sạch và tổng hợp dữ liệu.
* `02_Dashboards/`: Hình ảnh và file PDF của báo cáo Power BI.
* `03_Presentation/`: Slide thuyết trình chi tiết về Insight và Giải pháp.

---
*Author: Lê Hà CHức*
*Role: Data Analyst*
