# 1. Etapa de compilación (SDK de .NET 8)
FROM ://microsoft.com AS build-env
WORKDIR /app

# Copiar el archivo del proyecto y restaurar dependencias
COPY *.csproj ./
RUN dotnet restore

# Copiar todo lo demás y compilar el proyecto
COPY . ./
RUN dotnet publish -c Release -o out

# 2. Etapa de ejecución (Runtime de .NET 8)
FROM ://microsoft.com
WORKDIR /app
COPY --from=build-env /app/out .

# Forzar a .NET a escuchar en el puerto que Render espera
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Ejecutar la aplicación usando el nombre de tu proyecto
ENTRYPOINT ["dotnet", "PP2026_AsistenciaI46.dll"]

