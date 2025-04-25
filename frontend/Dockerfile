# ---------- Stage 1: Build ----------
    FROM node:16-alpine AS build
    WORKDIR /app
    COPY package*.json ./
    RUN npm install
    COPY . .
    RUN npm run build          # -> /app/build
    
    # ---------- Stage 2: Run with "serve" ----------
    FROM node:16-alpine
    WORKDIR /app
    COPY --from=build /app/build ./build
    RUN npm install serve
    ENV PORT=8080
    EXPOSE 8080
    CMD ["npx", "serve", "-s", "build", "-l", "8080"]
    