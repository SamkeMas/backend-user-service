# Etapa de construcción
FROM node:slim AS build

WORKDIR /app

COPY package*.json ./

COPY .env ./

RUN npm install

COPY . .

RUN npm run build

FROM node:slim

WORKDIR /app

COPY --from=build /app/dist ./dist
COPY --from=build /app/package*.json ./
COPY --from=build /app/.env ./

RUN npm install

EXPOSE 4001

CMD ["npm", "run", "prod"]
