FROM ://microsoft.com
WORKDIR /app

# Copia los archivos publicados desde tu carpeta Out local hacia el contenedor
COPY ./Out .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "PresentismoWebI46.dll"]


