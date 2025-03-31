FROM node:23-alpine

# 環境変数の定義
ARG database_url
ARG firebase_private_key
ARG firebase_client_email
ARG firebase_project_id
ARG firebase_api_key
ARG firebase_auth_domain
ARG firebase_storage_bucket
ARG firebase_messaging_sender_id
ARG firebase_app_id

# 環境変数を設定
ENV DATABASE_URL=$database_url
ENV FIREBASE_PRIVATE_KEY=$firebase_private_key
ENV FIREBASE_CLIENT_EMAIL=$firebase_client_email
ENV FIREBASE_PROJECT_ID=$firebase_project_id
ENV FIREBASE_API_KEY=$firebase_api_key
ENV FIREBASE_AUTH_DOMAIN=$firebase_auth_domain
ENV FIREBASE_STORAGE_BUCKET=$firebase_storage_bucket
ENV FIREBASE_MESSAGING_SENDER_ID=$firebase_messaging_sender_id
ENV FIREBASE_APP_ID=$firebase_app_id

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Generate Prisma client before building
RUN npx prisma generate

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]