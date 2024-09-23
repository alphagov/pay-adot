FROM amazon/aws-otel-collector:v0.40.2@sha256:ef91d5acc79f2472740452c0177b0170fe38c8092a990114c35f504c04f6c1ac

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
