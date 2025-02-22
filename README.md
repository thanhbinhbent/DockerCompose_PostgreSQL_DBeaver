# PostgreSQL với Docker Compose, Kết Nối bằng DBeaver

## Cấu trúc dự án

```
/project-name
│── docker-compose.yml
│── init.sql
│── README.md
```

- **docker-compose.yml**: Khởi chạy PostgreSQL với Docker.
- **init.sql**: File SQL chứa các lệnh tạo bảng và dữ liệu mẫu.
- **README.md**: Hướng dẫn sử dụng.

---

## Chạy PostgreSQL bằng Docker Compose

### Cài đặt Docker và Docker Compose

- Tải và cài đặt [Docker Desktop](https://www.docker.com/products/docker-desktop/) nếu bạn chưa có.
- Kiểm tra phiên bản Docker:
  ```sh
  docker --version
  ```
- Kiểm tra phiên bản Docker Compose:
  ```sh
  docker-compose --version
  ```

### Start container PostgreSQL

- Mở terminal và chạy lệnh sau trong thư mục chứa `docker-compose.yml`:
  ```sh
  docker-compose up -d
  ```
- Kiểm tra container đang chạy:
  ```sh
  docker ps
  ```

### Kiểm tra database đã được tạo

- Truy cập container PostgreSQL:
  ```sh
  docker exec -it postgres-db psql -U admin -d top_cv_hcmus
  ```
- Kiểm tra danh sách bảng:
  ```sql
  \dt
  ```

---

## Kết nối PostgreSQL bằng DBeaver

### Cài đặt DBeaver

- Tải và cài đặt DBeaver từ [DBeaver Download](https://dbeaver.io/download/).

### Kết nối đến PostgreSQL

1. Mở DBeaver.
2. Chọn **Database** > **New Connection**.
3. Chọn **PostgreSQL** và nhấn **Next**.
4. Nhập thông tin kết nối:
   - **Host**: `localhost`
   - **Port**: `5432`
   - **Database**: `top_cv_hcmus`
   - **Username**: `admin`
   - **Password**: `admin`
5. Nhấn **Test Connection** để kiểm tra.
6. Nếu kết nối thành công, nhấn **Finish**.

---

## 5. Xuất ERD (Entity Relationship Diagram)

1. Trong DBeaver, kết nối đến database `top_cv_hcmus`.
2. Mở **Database Navigator**, nhấn chuột phải vào database.
3. Chọn **ER Diagram** > **Create New ER Diagram**.
4. Xuất ERD bằng cách chọn **File** > **Export**.

---

## 6. Dừng và xóa container PostgreSQL

- Dừng container:
  ```sh
  docker-compose down
  ```
- Xóa dữ liệu cũ:
  ```sh
  docker volume rm final_project_postgres_data
  ```

---

## 7. Lưu ý

- Nếu gặp lỗi kết nối, kiểm tra container bằng:
  ```sh
  docker logs postgres-db
  ```
- Nếu bảng không được tạo, kiểm tra file `init.sql`.

Chúc bạn thành công! 🚀
