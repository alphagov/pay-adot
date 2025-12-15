FROM amazon/aws-otel-collector:v0.46.0@sha256:371d3c8b9b97d0ebd0c56eb6b1e4f3d2ba4980c255f67d02695158e5851c2b31

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
