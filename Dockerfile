##See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.
#
#FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
#WORKDIR /app
#EXPOSE 80
#EXPOSE 443
#
#FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
#WORKDIR /src
#COPY ["BlogApp/BlogApp.csproj", "BlogApp/"]
#RUN dotnet restore "BlogApp/BlogApp.csproj"
#COPY . .
#WORKDIR "/src/BlogApp"
#RUN dotnet build "BlogApp.csproj" -c Release -o /app/build
#
#FROM build AS publish
#RUN dotnet publish "BlogApp.csproj" -c Release -o /app/publish
#
#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "BlogApp.dll"]

# https://hub.docker.com/_/microsoft-dotnet-core

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build

WORKDIR /source
EXPOSE 8080
ENV ASPNETCORE_URLS=http://*:8080


# copy csproj and restore as distinct layers

COPY *.sln .

COPY BlogApp/*.csproj ./BlogApp/

RUN dotnet restore



# copy everything else and build app

COPY BlogApp/. ./BlogApp/

WORKDIR /source/BlogApp

RUN dotnet publish -c release -o /app --no-restore



# final stage/image

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1

WORKDIR /app

COPY --from=build /app ./

ENTRYPOINT ["dotnet", "BlogApp.dll"]