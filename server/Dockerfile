FROM oven/bun:canary-alpine AS base

# Set the working directory
WORKDIR /app

# Copy dependency files first for layer caching
COPY package.json bun.lock ./

# Install production dependencies only
RUN bun install --frozen-lockfile --production

# Copy application source
COPY src ./src

# Set environment variable
ENV NODE_ENV=production

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["bun", "run", "src/index.ts"]
