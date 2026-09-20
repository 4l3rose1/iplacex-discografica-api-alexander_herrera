# --- Construcción ---
FROM gradle:8.5-jdk21 AS builder

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src

RUN gradle bootJar --no-daemon

# --- Ejecución ---
FROM openjdk:21-slim

EXPOSE 8080

COPY --from=builder /home/gradle/src/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]