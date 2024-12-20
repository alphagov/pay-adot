FROM amazon/aws-otel-collector:v0.42.0@sha256:cd481b72f3b98710ba69c27dca5a329a9d57808d9c74b288cb26c177938cbcf1

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
