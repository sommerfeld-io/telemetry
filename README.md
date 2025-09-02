# Telemetry

A simple telemetry setup using Docker Compose. This repo provides stacks to run Prometheus. Loki and Grafana and to expose metrics.

- [How to Contribute](https://github.com/sommerfeld-io/.github/blob/main/CONTRIBUTING.md)

<!-- ![Project Logo](https://raw.githubusercontent.com/sommerfeld-io/telemetry/refs/heads/main/.assets/logo.png) -->

## Warning: This Setup is intended for our infrastructure

Feel free to use this repository as a starting point for your own configuration. This config references hosts and servers by name simply starting the services will not work for you. You need to adjust at least the host names of the machines you want to observe.

## Stack: Telemetry

Lorem ipsum ...

## Stack: Metrics

The `metrics` Docker stack (see [`components/metrics`](components/metrics) folder) is a Docker Compose configuration that manages all of the needed exporters to monitor system metrics with Prometheus and Grafana. By using the`metrics` Docker stack, you can quickly and easily deploy all of the necessary components for monitoring your system metrics. This includes exporters for various system metrics, such as CPU usage, disk usage, and network activity.

| Component     | Port | URL                     |
| ------------- | ---- | ----------------------- |
| node_exporter | 9100 | <http://localhost:9100> |
| cAdvisor      | 9110 | <http://localhost:9110> |

## Risks and Technical Debts

All issues labeled as `risk` (= some sort of risk or a technical debt) or `security` (= disclosed security issues - e.g. CVEs) [are tracked as GitHub issue](https://github.com/sommerfeld-io/telemetry/issues?q=is%3Aissue+label%3Asecurity%2Crisk+is%3Aopen) and carry the respective label.

## Contact

Feel free to contact me via <sebastian@sommerfeld.io> or [raise an issue in this repository](https://github.com/sommerfeld-io/telemetry/issues).
