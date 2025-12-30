FROM openjdk:8u342-jre-slim

WORKDIR /workspace

COPY target/lib/jetty-runner.jar /workspace/jetty-runner.jar
COPY target/*.war /workspace/application.war
COPY src/main/swagger/swagger.yaml /workspace/
COPY inflector.yaml /workspace/
COPY src/main/resources/certs/*.pem /workspace/amaseguros.local.2027.pem

RUN keytool -import -trustcacerts -noprompt -keystore /usr/local/openjdk-8/lib/security/cacerts -storepass changeit -alias "*.ama-seguros-2027" -file /workspace/amaseguros.local.2027.pem

EXPOSE 8080

CMD ["java", "-jar", "-DswaggerUrl=swagger.yaml", "/workspace/jetty-runner.jar", "/workspace/application.war"]

