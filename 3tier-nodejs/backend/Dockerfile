# Stage 1: Build Stage
FROM node:14-alpine AS builder
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install
COPY . .


# Stage 2: Production Stage
FROM node:14-alpine
WORKDIR /usr/src/app

# Copy only the necessary artifacts from the builder stage
COPY --from=builder /usr/src/app .



EXPOSE 3001


CMD ["node", "server.js"]