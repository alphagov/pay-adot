FROM amazon/aws-otel-collector:v0.39.1@sha256:5f48cf9d077fa5afc4622ce83741a407f1880f5d0626df637271cb4b60a73955

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
