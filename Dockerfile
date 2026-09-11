# 1. ETAPA DE COMPILACIÓN (Usamos el SDK de .NET 8)
FROM ubuntu:22.04 AS build
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    dotnet-sdk-8.0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

# Copiamos los archivos de código fuente directamente
COPY . .

# Restauramos y compilamos de forma nativa para Linux
RUN dotnet restore "PresentismoWebI46.csproj"
RUN dotnet publish "PresentismoWebI46.csproj" -c Release -o /app/publish /p:UseAppHost=false

# 2. ETAPA DE EJECUCIÓN (Entorno ligero de producción)
FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    dotnet-runtime-8.0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "PresentismoWebI46.dll"]



