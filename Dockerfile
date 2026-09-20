# --- Construcción ---
FROM gradle:8.5-jdk21 AS builder

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src

RUN chmod +x ./gradlew
RUN ./gradlew bootJar --no-daemon

# --- Ejecución ---
FROM eclipse-temurin:21-jre

EXPOSE 8080

COPY --from=builder /home/gradle/src/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]