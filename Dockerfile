FROM amazon/aws-otel-collector:v0.41.0@sha256:7edf4972419b52c3259d1118a9506d883e15dbb7bfb4cc7d90dfc16b68594233

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
