# NOTLAR

### VPS Server

- \*VPS Server bağlan: `ssh root@45.133.178.135`
- \*Güncel kodu çek: `git pull`
- docker dosyalarında bir değişiklik yapmış isen ilk önce docker i kapatmalısın: `docker compose down`
- \*Tekrar build al: `docker compose up -d --build`
- \*prisma/schema.prisma dosyan değişmiş ise çalıştır: `docker compose exec web npx prisma migrate deploy`
- Bu komutta var ama bu işi zaten Dockerfile hallediyormuş çalıştırmana gerek yok: `docker compose exec web npx prisma generate`
- Seed dosyandaki verileri veritabanına eklemek istersen: `docker compose exec web npx tsx ./db/seed.ts`

### Local

- Sadece ilk seferde build al: `docker compose up -d --build`
- \*Docker container çalıştır(sadece db): `docker compose up db`
- Docker container durdur: `docker compose down`
- \*Nextjs proje çalıştır: `npm run dev`
- Prisma client kodunu tekrar oluşturur: `npx prisma generate`
- Prisma şemalarında yaptığın değişiklikleri migrate et: `npx prisma migrate dev --name added_xxx`
- Prisma studio çalıştır: `npx prisma studio`

### Docker

- Durum sorgula: `docker ps`

### Prisma

- Dosyada oluşturduğun datayı veritabanına atma: `npx tsx ./db/seed`

### PostgreSQL

- Bağlanmak istediğin veritabanı bilgilerini gir: `docker exec -it <container_adi> psql -U <kullanici_adi> -d <veritabani_adi>`
- Bağlanmak istediğin veritabanı bilgilerini gir(benim bilgiler): `docker exec -it atak-db psql -U atak_user -d atak_db`
- Tüm veritabanlarını listele: `\l`
- Mevcut veritabanındaki tabloları listele: `\dt`
- Product tablosundaki 5 elemanı gör: `SELECT * FROM "Product" LIMIT 5;`
- Postgreden çık: `\q`
