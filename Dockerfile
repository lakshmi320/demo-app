#---------BUILD STAGE-------
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /usr/src/app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

#-----RUN STAGE-------
FROM eclipse-temurin:21-jre
WORKDIR /usr/app

COPY --from=build /usr/src/app/target/*.jar app.jar

EXPOSE 8080
CMD ["java","-jar","app.jar"]

