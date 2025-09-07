# 1. Aşama: Dependencies
FROM node:20-alpine AS deps
WORKDIR /app

# package.json ve lock dosyaları kopyalanır
COPY package*.json ./
RUN npm ci --frozen-lockfile --only=production

# 2. Aşama: Builder
FROM node:20-alpine AS builder
WORKDIR /app

# Dependencies'leri önceki stage'den al
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Prisma client generate
RUN npx prisma generate

# Build script'ini güncelle - database bağlantısı olmadan build
ENV SKIP_ENV_VALIDATION=true
ENV DATABASE_URL="postgresql://dummy:dummy@localhost:5432/dummy"
RUN npm run build

# 3. Aşama: Production Image
FROM node:20-alpine AS runner
WORKDIR /app

# Non-root user oluştur
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Ortam değişkenlerini production'a al
ENV NODE_ENV=production

# Sadece gerekli dosyaları kopyala
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma

# Prisma binary'lerini kopyala
COPY --from=builder /app/node_modules/@prisma/client ./node_modules/@prisma/client

# Ownership değiştir
RUN chown -R nextjs:nodejs /app
USER nextjs

# 3000 portunu aç
EXPOSE 3000

# Start script (docker-compose'da override edilecek)
CMD ["node", "server.js"]