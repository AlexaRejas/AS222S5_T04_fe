# Etapa 1: Construcción
FROM node:18 AS build

# Crear el directorio de trabajo
WORKDIR /app

# Copiar archivos necesarios para instalar dependencias
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto del código fuente
COPY . ./

# Construir la aplicación en modo producción
RUN npm run build --prod

# Etapa 2: Producción
FROM nginx:alpine AS production

# Copiar los archivos construidos a la carpeta de NGINX
COPY --from=build /app/dist/tu-proyecto /usr/share/nginx/html

# Exponer el puerto para NGINX
EXPOSE 80

# Iniciar NGINX
CMD ["nginx", "-g", "daemon off;"]
