FROM node:23-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Generate Prisma client before building
RUN npx prisma generate

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]