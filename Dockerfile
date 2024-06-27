FROM amazon/aws-otel-collector:v0.40.0@sha256:cdd2092033efbad8f4289eb53c2d729fdc2167b5395d71c175628f7eb1eb78aa

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
