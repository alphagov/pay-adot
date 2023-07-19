# pay-adot

GOV.UK Implementation of Amazon Distribution for Open Telemetry as a Fargate sidecar.

The sidecar will scrape `/metrics` on the configured container port and push the scraped metrics to a remote prometheus instance.

Authentication with the remote prometheus instance will be done by assuming a role and signing requests using AWS SigV4
authentication.

## Environment variables

The following environment variables must be set for this container to function:

Environment variable | Example | Description
---------------------|---------|------------
APPLICATION\_PORT | `3000` | Open Telemetry will connect to this port on localhost to scrape the /metrics endpoint
PROMETHEUS\_ENDPOINT\_URL | `https://aps-workspaces.eu-west-1.amazonaws.com/workspaces/ws-01234567-89ab-cdef-0123456789ab/` | The full endpoint URL exposing a prometheus remote write receiver
PROMETHEUS\_WRITE\_ASSUME\_ROLE\_ARN | `arn:aws:iam::12345678:role/example-role` | The ARN of the role to assume when writing to prometheus
AWS\_REGION | `eu-west-1` | The region in which to assume the role specified in PROMETHEUS\_WRITE\_ASSUME\_ROLE\_ARN

## Licence

[MIT License](LICENSE)

## Vulnerability Disclosure

GOV.UK Pay aims to stay secure for everyone. If you are a security researcher and have discovered a security vulnerability in this code, we appreciate your help in disclosing it to us in a responsible manner. Please refer to our [vulnerability disclosure policy](https://www.gov.uk/help/report-vulnerability) and our [security.txt](https://vdp.cabinetoffice.gov.uk/.well-known/security.txt) file for details.
