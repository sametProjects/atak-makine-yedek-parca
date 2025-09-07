# 1. Aşama: Build
FROM node:20-alpine AS builder
WORKDIR /app

# package.json ve lock dosyaları kopyalanır
COPY package*.json ./

# Production için sadece gerekli paketleri kur
RUN npm install --frozen-lockfile

# Proje dosyalarını kopyala
COPY . .

# Build al
RUN npm run build

# 2. Aşama: Production Image
FROM node:20-alpine AS runner
WORKDIR /app

# Ortam değişkenlerini production'a al
ENV NODE_ENV=production

# Build edilen çıktıyı al
COPY --from=builder /app ./

# 3000 portunu aç
EXPOSE 3000

# Next.js başlat
CMD ["npm", "run", "start"]
