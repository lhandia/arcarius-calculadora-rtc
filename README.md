# arcarius-calculadora-rtc

Imagem de deploy da Calculadora oficial da Reforma Tributaria (Receita Federal),
consumida pelo Arcarius pela rota `/rtc-proxy` do proxy.

Nao ha codigo proprio aqui: o build clona a versao oficial mais recente
(`ReceitaFederal/calculadora-rtc-regime-regular`), gera o banco SQLite oficial e
empacota o JAR. Para atualizar, basta refazer o deploy no Railway.

## Railway

1. New > Deploy from GitHub repo > `arcarius-calculadora-rtc`
2. O Dockerfile e detectado automaticamente. Nao gere dominio publico.
3. No servico do proxy, defina `RTC_CALCULADORA_URL` =
   `http://<nome-do-servico>.railway.internal:8080`

Endpoint usado pelo Arcarius: `POST /api/calculadora/regime-geral`
