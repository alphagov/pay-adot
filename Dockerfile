FROM amazon/aws-otel-collector:v0.43.2@sha256:d4847a782c216ab696b48bba715d608b3bef1a1b15f7d25014a0b9d0838c4fd8

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
