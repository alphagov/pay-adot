FROM amazon/aws-otel-collector:v0.37.0@sha256:2d79b28712a05c03dbae737dddb7b48be63fe4465e5e3239d72460f77078242b

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
