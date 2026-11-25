
# Etapa 1: Compilación
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build

WORKDIR /src

# Copiar el archivo del proyecto
COPY *.csproj ./

# Restaurar dependencias
RUN dotnet restore

# Copiar el código fuente
COPY . .

# Compilar y publicar
RUN dotnet publish -c Release -o /app/publish --no-restore

# Etapa 2: Ejecución
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final

WORKDIR /app

# Copiar los archivos publicados
COPY --from=build /app/publish .

# Configuración del servidor
ENV ASPNETCORE_HTTP_PORTS=8080

EXPOSE 8080

# Adaptar al nombre del proyecto
ENTRYPOINT ["dotnet", "Prueba_RENDER.dll"]
