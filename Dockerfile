FROM amazon/aws-otel-collector:v0.44.0@sha256:089240fee2d7d6d4be199e6c59544dec83505350e1d24cac8331a663119a4584

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
