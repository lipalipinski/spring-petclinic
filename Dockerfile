FROM maven:3.9.3-eclipse-temurin-17 AS builder

COPY src /usr/src/app/src
COPY pom.xml /usr/src/app

RUN mvn -f /usr/src/app/pom.xml clean package

# https://github.com/GoogleContainerTools/distroless
FROM gcr.io/distroless/java17-debian11 
WORKDIR /opt/app
COPY --from=builder /usr/src/app/target/*.jar app.jar
EXPOSE 8080
CMD [ "app.jar" ]
