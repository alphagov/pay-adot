FROM amazon/aws-otel-collector:v0.43.1@sha256:db725ac7007ef1d9b5a357a59f3b964ab9e1df23ebb0dfc694275019048b489b

ENV OTEL_LOG_LEVEL=INFO

COPY config.yml /etc/ecs/govuk-pay-adot-sidecar-config.yaml

CMD ["--config=/etc/ecs/govuk-pay-adot-sidecar-config.yaml"]
