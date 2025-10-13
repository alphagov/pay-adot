FROM amazon/aws-otel-collector:v0.45.1@sha256:4eabdc3213c7897d12df8daa4b8f1bf2fd3ebffc72ccdb8279102169a932342e

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
