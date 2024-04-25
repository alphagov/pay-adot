FROM amazon/aws-otel-collector:v0.38.2@sha256:4ca2ffe73e850738db7fdf671090511c50391b2e1492dc90d4ebcc2204b5fcde

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
