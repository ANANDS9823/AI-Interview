FROM node:22-alpine

WORKDIR /app

# Copy dependency manifests
COPY package*.json ./

# Install all dependencies (including devDependencies like tailwindcss needed for building Next.js)
RUN npm install --include=dev

# Copy application source code
COPY . .

# Build the Next.js application
RUN npm run build

# Set environment variables for production runtime and Hugging Face Spaces
ENV NODE_ENV=production \
    PORT=7860 \
    HOSTNAME="0.0.0.0"

# Create non-root user with UID 1000 for Hugging Face Spaces compatibility
RUN adduser -D -u 1000 user && \
    chown -R user:user /app

USER user

EXPOSE 7860

CMD ["npm", "start"]