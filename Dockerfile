# Usamos una base estable de Linux Ubuntu
FROM ubuntu:22.04

# Instalamas el entorno de ejecución de .NET 8 y dependencias necesarias
RUN apt-get update && apt-get install -y \
    dotnet-runtime-8.0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiamos tu carpeta compilada local
COPY ./Out .

# Configuramos el puerto para Render
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Ejecutamos tu aplicación
ENTRYPOINT ["dotnet", "PresentismoWebI46.dll"]


