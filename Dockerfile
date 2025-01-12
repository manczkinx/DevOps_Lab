# Etap 1: Zbudowanie aplikacji
FROM maven:3.8.6-openjdk-17-slim AS build

# Ustawienie katalogu roboczego
WORKDIR /app

# Kopiowanie pliku pom.xml i pobieranie zależności
COPY pom.xml .
RUN mvn dependency:go-offline

# Kopiowanie całego projektu i kompilowanie aplikacji
COPY src ./src
RUN mvn clean package -DskipTests

# Użyj obrazu Javy jako bazowego
FROM openjdk:17-jdk-slim

# Skopiuj plik .jar do kontenera
COPY target/springboot-demo-0.0.1-SNAPSHOT.jar /app/springboot-demo.jar

# Określ, jak uruchomić aplikację Spring Boot
ENTRYPOINT ["java", "-jar", "/springboot-demo.jar"]

# Użyj domyślnego portu 9090
EXPOSE 9090
