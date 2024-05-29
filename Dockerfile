FROM maven:3.6.3-openjdk-14-slim AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY /initial/pom.xml /workspace
COPY /initial/src /workspace/src
#RUN mvn -B package --file pom.xml -DskipTests
RUN mvn compile

FROM openjdk:14-slim
COPY --from=build /workspace/target/*jar-with-dependencies.jar app.jar
EXPOSE 6379
ENTRYPOINT ["java","-jar","app.jar"]
