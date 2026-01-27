FROM amazon/aws-otel-collector:v0.47.0@sha256:40a7eb9bfa58871d5d6dbdfcb146bc9d7eb4f149b42bd653809cd5b980af0cc4

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
