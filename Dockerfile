# 1. Etapa de compilación (SDK de .NET)
FROM ://microsoft.com AS build-env
WORKDIR /app

# Copiar archivos del proyecto y restaurar dependencias
COPY *.csproj ./
RUN dotnet restore

# Copiar el resto de los archivos y compilar
COPY . ./
RUN dotnet publish -c Release -o out

# 2. Etapa de ejecución (Runtime de .NET)
FROM ://microsoft.com
WORKDIR /app
COPY --from=build-env /app/out .

# Configurar el puerto que Render exige (habitualmente el 8080 en .NET 8)
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Comando para iniciar la aplicación (Cambiá "TuProyecto.dll" por el tuyo)
ENTRYPOINT ["dotnet", "TuProyecto.dll"]
