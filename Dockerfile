FROM docker.io/library/maven:3.10.0-eclipse-temurin-17-noble AS build

WORKDIR /build

COPY pom.xml .
COPY src ./src

RUN mvn -B package


FROM docker.io/library/tomcat:10.1.60-jre17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /build/target/war-tomcat-cicd-lab.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

