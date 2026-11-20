# Calculadora oficial da Reforma Tributaria (Receita Federal) - imagem de deploy
# Clona a versao oficial mais recente a cada build, gera o banco SQLite e empacota o JAR.
# Endpoint exposto: POST /api/calculadora/regime-geral

FROM eclipse-temurin:25-jdk AS build
RUN apt-get update \
    && apt-get install -y --no-install-recommends git ca-certificates maven \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN git clone --depth 1 https://github.com/ReceitaFederal/calculadora-rtc-regime-regular.git .
RUN mkdir -p ./calculadora/db \
    && mvn flyway:migrate -Dflyway.configFiles=./flyway/flyway-pro.conf --batch-mode --errors \
    && mvn clean package -DskipTests --batch-mode

FROM eclipse-temurin:25-jdk
WORKDIR /app
COPY --from=build /app/target/api-regime-geral.jar /app/api-regime-geral.jar
COPY --from=build /app/calculadora/db /app/calculadora/db
ENV SERVER_PORT=8080
EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.profiles.active=offline", "-jar", "/app/api-regime-geral.jar"]
