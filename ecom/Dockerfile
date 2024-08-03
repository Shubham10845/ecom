FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests

FROM openjdk:17

WORKDIR /app

COPY --from=build /app/target/spring-boot-docker.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
