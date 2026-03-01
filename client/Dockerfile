FROM oven/bun:canary-alpine AS base

# Set the working directory
WORKDIR /app

# Copy dependency files first for layer caching
COPY package.json bun.lock ./

FROM base AS builder

# Install all dependencies including dev dependencies for build
RUN bun install --frozen-lockfile

# Copy application source
COPY . .

# Set environment variable
ENV NODE_ENV=production

# Build the application
RUN bun run build

FROM nginx:1.29.5-alpine-slim AS production

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

FROM base AS development

# Install all dependencies including dev dependencies
RUN bun install --frozen-lockfile

# Set environment variable
ENV NODE_ENV=development

EXPOSE 8080

CMD ["bun", "run", "dev"]
