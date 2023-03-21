FROM arm64v8/openjdk:17 as build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw install -DskipTests

FROM arm64v8/openjdk:17
COPY --from=build /workspace/app/target/*.jar /app/app.jar
ENTRYPOINT ["java","-jar","/app/app.jar"]