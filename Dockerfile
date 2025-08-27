FROM amazon/aws-otel-collector:v0.45.0@sha256:dec70649a0756de848d1c687c568e8343a526f2ba994b08f1b963d98e00ea98d

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
