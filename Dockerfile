FROM amazon/aws-otel-collector:v0.43.0@sha256:e25f55ca7749616fd2b7b78bd9324ac23d1a9a351b365ebca35cd1c12b76eef2

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
