FROM maven:3.5.4-jdk-8-alpine as maven
COPY ./pom.xml ./pom.xml
COPY ./src ./src
RUN mvn dependency:go-offline -B
RUN mvn package
FROM openjdk:8u171-jre-alpine
WORKDIR /app
COPY --from=maven target/my-app-1.0-SNAPSHOT.jar ./my-app-1.0-SNAPSHOT.jar
CMD ["java", "-cp", "target/my-app-1.0-SNAPSHOT.jar","com.mycompany.app.App"]
