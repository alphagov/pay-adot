FROM amazon/aws-otel-collector:v0.39.0@sha256:29228f4afc1624611d232c062e5a6e73b58d4ab3fa5f64c166b162ea9a0ada59

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
