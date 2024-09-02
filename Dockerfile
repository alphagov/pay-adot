FROM amazon/aws-otel-collector:v0.40.1@sha256:ef985dfdb6cad775d5a13ae51410d862ed6cda0555b672868e734c3ae51d0516

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
