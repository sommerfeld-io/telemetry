# Telemetry

A simple telemetry setup using Docker Compose. This repo provides stacks to run Prometheus, Loki and Grafana and to expose metrics.

![Project Logo](https://raw.githubusercontent.com/sommerfeld-io/telemetry/refs/heads/main/.assets/logo.png)

## Warning: This setup is intended for our infrastructure

Feel free to use this repository as a starting point for your own configuration. However, this config references hosts and servers by name. So simply starting the services will most likely not work for you. You need to adjust at least the host names of the machines you want to observe.

## Stacks

- [k6](components/k6/README.md): A load testing setup.
- [Metrics](components/metrics/README.md): A collection of Exporters to expose metrics from various services.
- [Telemetry](components/telemetry/README.md): A complete monitoring stack based on Prometheus, Grafana and Loki.

## Risks and Technical Debts

All issues labeled as `risk` (= some sort of risk or a technical debt) or `security` (= disclosed security issues - e.g. CVEs) [are tracked as GitHub issue](https://github.com/sommerfeld-io/telemetry/issues?q=is%3Aissue+label%3Asecurity%2Crisk+is%3Aopen) and carry the respective label.

## Contact

Feel free to contact me via <sebastian@sommerfeld.io> or [raise an issue in this repository](https://github.com/sommerfeld-io/telemetry/issues).
