# 1. Build aşaması
FROM node:18-alpine AS builder
WORKDIR /app

# package.json ve lock dosyasını kopyala
COPY package*.json ./

# bağımlılıkları yükle
RUN npm install

# tüm kodu kopyala
COPY . .

# production için build
RUN npm run build

# 2. Runtime aşaması
FROM node:18-alpine AS runner
WORKDIR /app

# sadece production bağımlılıkları
COPY package*.json ./
RUN npm install --omit=dev

# build klasörünü kopyala
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/next.config.mjs ./
COPY --from=builder /app/package*.json ./

EXPOSE 3000

CMD ["npm", "start"]
