# NOTLAR

### VPS Server

- \*VPS Server bağlan: `ssh root@45.133.178.135`
- \*Güncel kodu çek: `git pull`
- docker dosyalarında bir değişiklik yapmış isen ilk önce docker i kapatmalısın: `docker compose down`
- \*Tekrar build al: `docker compose up -d --build`
- prisma/schema.prisma dosyan değişmiş ise çalıştır: `docker compose exec web npx prisma migrate deploy`
- prisma/schema.prisma dosyan değişmiş ise çalıştır: `docker compose exec web npx prisma generate`

### Local

- Sadece ilk seferde build al: `docker compose up -d --build`
- \*Docker container çalıştır(sadece db): `docker compose up db`
- Docker container durdur: `docker compose down`
- \*Nextjs proje çalıştır: `npm run dev`
- Prisma şemalarında yaptığın değişiklikleri migrate et: `npx prisma migrate dev --name added_xxx`
- Prisma client kodunu tekrar oluşturur: `npx prisma generate`
- Prisma studio çalıştır: `npx prisma studio`

### Docker

- Durum sorgula: `docker ps`
