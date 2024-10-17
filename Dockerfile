FROM amazon/aws-otel-collector:v0.41.1@sha256:2fbdee4adde727cbab0e4f8362b4f1b32c7737053ffca7dcd7ac93f7a322f4d3

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
