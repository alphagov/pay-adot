FROM amazon/aws-otel-collector:v0.37.1@sha256:9970502a2928bbaad02be965086bcb9ddfe57f7b0f6941f94b4b5bd5629796f3

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
