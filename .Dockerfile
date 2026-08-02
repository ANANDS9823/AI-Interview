FROM node:18-alpine

WORKDIR /app

# Set environment variables for production and Hugging Face Spaces
ENV NODE_ENV=production \
    PORT=7860 \
    HOSTNAME="0.0.0.0"

# Copy dependency manifests
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application source code
COPY . .

# Build the Next.js application
RUN npm run build

# Create non-root user with UID 1000 for Hugging Face Spaces compatibility
RUN adduser -D -u 1000 user && \
    chown -R user:user /app

USER user

EXPOSE 7860

CMD ["npm", "start"]