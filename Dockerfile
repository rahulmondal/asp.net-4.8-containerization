FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS builder
WORKDIR /app
COPY EtoDockerTest/. .
RUN nuget restore -PackagesDirectory ../packages
RUN msbuild EtoDockerTest.csproj /p:Configuration=Debug  \
    /p:DeployOnBuild=True  \
    /p:DeployDefaultTarget=WebPublish  \
    /p:WebPublishMethod=FileSystem  \
    /p:DeleteExistingFiles=True  \
    /p:publishUrl=c:\out

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022
WORKDIR c:/inetpub/wwwroot
COPY --from=builder c:/out .