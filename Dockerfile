# Usamos la imagen oficial de .NET desde el registro de Docker Hub
FROM docker.io/aspnetruntime/core:8.0
WORKDIR /app

# Copiamos tu carpeta compilada local
COPY ./Out .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "PresentismoWebI46.dll"]


