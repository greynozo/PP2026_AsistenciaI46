# Truco para evitar que Render recorte la palabra mcr
ARG REGISTRY=mcr.microsoft.com

# 1. Etapa de compilación
FROM ${REGISTRY}/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copiar el archivo del proyecto y restaurar
COPY *.csproj ./
RUN dotnet restore

# Copiar todo lo demás y compilar
COPY . ./
RUN dotnet publish -c Release -o out

# 2. Etapa de ejecución
FROM ${REGISTRY}/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# Configuración de puertos para Render
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "PP2026_AsistenciaI46.dll"]


