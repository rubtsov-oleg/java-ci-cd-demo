# Используем образ с OpenJDK
ARG BASE_IMAGE=linux

FROM openjdk:17-jdk-slim AS linux-base
WORKDIR /app

FROM mcr.microsoft.com/windows/servercore:ltsc2022 AS windows-base
WORKDIR /app

FROM ${BASE_IMAGE}-base AS final

# Копируем файл pom.xml для скачивания зависимостей
COPY demo/pom.xml /app/demo/

# Копируем исходный код в контейнер
COPY demo /app/demo

COPY demo/mvnw /app/demo/mvnw
COPY demo/.mvn /app/demo/.mvn
COPY demo/mvnw.cmd /app/demo/mvnw.cmd

RUN if [ "${BASE_IMAGE}" = "linux" ]; then chmod +x /app/demo/mvnw; fi

# Переходим в директорию demo и запускаем сборку
WORKDIR /app/demo
RUN ./mvnw clean package || demo\mvnw.cmd clean package

# Указываем команду для запуска приложения
CMD ["java", "-cp", "target/classes", "org.example.Main"]
