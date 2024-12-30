# Используем образ с OpenJDK
FROM openjdk:17-jdk-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файл pom.xml для скачивания зависимостей
COPY demo/pom.xml /app/demo/

# Копируем исходный код в контейнер
COPY demo /app/demo

COPY demo/mvnw /app/demo/mvnw
COPY demo/.mvn /app/demo/.mvn

RUN chmod +x /app/demo/mvnw
# Переходим в директорию demo и запускаем сборку
WORKDIR /app/demo
RUN ./mvnw clean package

# Указываем команду для запуска приложения
CMD ["java", "-cp", "target/classes", "org.example.Main"]
