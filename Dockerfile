FROM ubuntu:12.04

MAINTAINER Kimbro Staken version: 0.1

FROM microsoft/dotnet:sdk 
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o publishdir

FROM microsoft/dotnet:aspnetcore-runtime AS runtime
EXPOSE 5555
WORKDIR /app
COPY --from=build /app/publishdir .
ENTRYPOINT ["dotnet", "WebAppContainer.dll"]
