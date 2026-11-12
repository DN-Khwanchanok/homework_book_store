# Book Store

เว็บร้านหนังสือด้วย Ruby on Rails ผู้ใช้ค้นหาและดูรายละเอียดหนังสือได้ ส่วน Admin จัดการข้อมูลร้านผ่านหน้าเว็บ

## สิ่งที่ทำตาม Requirements

| ส่วน | ความสามารถ |
| --- | --- |
| ผู้ใช้ทั่วไป | เข้าสู่ระบบและออกจากระบบ ดูรายการหนังสือ กรองตามหมวดหมู่ ค้นหาด้วยชื่อ และกดชื่อเพื่อเปิดหน้ารายละเอียด |
| ผู้ดูแลระบบ | เฉพาะ Admin เข้า `/admin` และเพิ่ม แก้ไข หรือลบหนังสือ หมวดหมู่ และตลาดได้ |
| บัญชีผู้ใช้ | Admin สร้างบัญชีใหม่และเลือก Role เป็น User หรือ Admin ได้ มี seed สำหรับสร้างบัญชี Admin เริ่มต้น |
| ความสัมพันธ์ | Category หนึ่งรายการมีหลาย Book และ Book กับ Market เชื่อมกันแบบหลายต่อหลายผ่าน BookMarket |
| JSON API | ดูรายการและรายละเอียดของ Book, Category, Market และ User รวม 8 endpoints |

### JSON API

| โมเดล | รายการ | รายละเอียด | สิทธิ์ |
| --- | --- | --- | --- |
| Book | `GET /api/books` | `GET /api/books/:id` | บัญชีที่ล็อกอิน |
| Category | `GET /api/categories` | `GET /api/categories/:id` | บัญชีที่ล็อกอิน |
| Market | `GET /api/markets` | `GET /api/markets/:id` | บัญชีที่ล็อกอิน |
| User | `GET /api/users` | `GET /api/users/:id` | Admin |

คำสั่งเพิ่ม แก้ไข และลบข้อมูลใช้ routes ของหน้า Admin เช่น `POST /admin/books`, `PATCH /admin/books/:id` และ `DELETE /admin/books/:id`

## วิธีเปิดโปรเจกต์

ใช้ Ruby 4.0.9 ตาม [mise.toml](mise.toml), Rails 8.1.4.1 ตาม [Gemfile.lock](Gemfile.lock) และ PostgreSQL ที่เปิดอยู่ โดยบัญชี PostgreSQL ต้องสร้างฐานข้อมูลสำหรับ development ได้

เปิด Terminal ในโฟลเดอร์โปรเจกต์ แล้วรันคำสั่งต่อไปนี้ หากใช้ mise ให้เติม `mise exec --` หน้าคำสั่ง Ruby หรือ Rails

```bash
bundle install
bin/rails db:prepare
```

สร้างบัญชี Admin เริ่มต้นผ่าน [db/seeds.rb](db/seeds.rb) โดยเปลี่ยนตัวอย่างอีเมลเป็นอีเมลที่ต้องการ

```bash
read -rsp "Admin password: " admin_password
printf '\n'
ADMIN_EMAIL=admin@example.com ADMIN_PASSWORD="$admin_password" bin/rails db:seed
unset admin_password
```

```bash
bin/rails server -b 127.0.0.1
```

เปิด [หน้าร้านหนังสือ](http://127.0.0.1:3000) แล้วล็อกอินด้วยบัญชีที่สร้างไว้

## ไฟล์และวิธีรัน Bruno

Bruno Collection อยู่ที่ [test_api/Test-BookStore](test_api/Test-BookStore) โดยมี [opencollection.yml](test_api/Test-BookStore/opencollection.yml) เป็นไฟล์ตั้งค่า Collection และ [Local.yml](test_api/Test-BookStore/environments/Local.yml) เป็นไฟล์ตั้งค่า Environment ส่วนไฟล์ `.yml` ในแต่ละโฟลเดอร์คือ requests และเงื่อนไขที่ Bruno ใช้ตรวจผล

| โฟลเดอร์ | จำนวน requests | สิ่งที่ทดสอบ |
| --- | ---: | --- |
| [01 Guest](test_api/Test-BookStore/01-Guest) | 9 | เรียก API ทั้ง 8 endpoints โดยยังไม่ล็อกอินต้องได้ `401` และเปิด `/admin` ต้องถูกส่งไปหน้า Sign in ด้วย `302` |
| [02 Regular user](test_api/Test-BookStore/02-Regular-user) | 25 | อ่านข้อมูลร้านได้ ทดสอบ ID ที่ไม่มี และตรวจว่าคำสั่งที่สงวนให้ Admin ถูกปฏิเสธด้วย `403` |
| [03 Admin](test_api/Test-BookStore/03-Admin) | 17 | เข้า `/admin` ได้ จัดการหนังสือ หมวดหมู่ และตลาด ดูข้อมูลผู้ใช้ สร้างบัญชีทั่วไป และลองส่งราคาหนังสือติดลบให้ได้ `422` |

1. เตรียมบัญชี Admin กับ User ทั่วไปอย่างละหนึ่งบัญชี และเตรียมหนังสือ หมวดหมู่ และตลาดอย่างละหนึ่งรายการเพื่อทดสอบ API รายละเอียด
2. เปิด Bruno แล้วใช้ **Open Collection** เลือกโฟลเดอร์ `test_api/Test-BookStore`
3. เลือก Environment **Local** ตั้ง `base_url` เป็น `http://127.0.0.1:3000` แล้วกรอก `regular_email`, `regular_password`, `admin_email` และ `admin_password` ใน Bruno
4. ใช้ **Run Collection** เพื่อรันตามลำดับ มีทั้งหมด 51 requests และ 61 tests เคสชื่อ `failed_` จะขึ้น **PASS** เมื่อระบบปฏิเสธตามที่คาด

ถ้ารันชุด Admin บนฐานข้อมูลที่ใช้งานอยู่ เคส `Create user` จะบันทึกบัญชีทดสอบหนึ่งบัญชีต่อรอบ
