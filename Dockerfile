FROM amazon/aws-otel-collector:v0.38.1@sha256:37bb5ca9646b5a053517a63a31aab10b98394e08b22bba1aa6410350560ec66c

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
