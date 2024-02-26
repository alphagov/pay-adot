FROM amazon/aws-otel-collector:v0.38.0@sha256:08123a2ff4aa82937d37bf98f7ebb7baac1ab6c4cbda4b5b0843b00c3df879bd

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
