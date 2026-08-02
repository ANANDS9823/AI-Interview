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

# Change ownership to pre-existing 'node' user (UID 1000) included in node:22-alpine
RUN chown -R node:node /app

USER node

EXPOSE 7860

CMD ["npm", "start"]