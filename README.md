# Telemetry

A simple telemetry setup using Docker Compose. This repo provides stacks to run Prometheus. Loki and Grafana and to expose metrics.

<!-- ![Project Logo](https://raw.githubusercontent.com/sommerfeld-io/telemetry/refs/heads/main/.assets/logo.png) -->

## Warning: This Setup is intended for our infrastructure

Feel free to use this repository as a starting point for your own configuration. This config references hosts and servers by name simply starting the services will not work for you. You need to adjust at least the host names of the machines you want to observe.

## Stack: Telemetry

The Docker Compose stack is designed to run on a dedicated Raspberry Pi, serving as the central monitoring server for the homelab environment. The stack continuously collects, stores, and visualizes metrics from various devices and services across the network. This setup provides a solution for tracking system health, performance, and service availability in the self-hosted infrastructure.

| Component         | Port | URL                     | Info          |
| ----------------- | ---- | ----------------------- | ------------- |
| Prometheus        | 9090 | <http://localhost:9100> | -             |
| Grafana           | 3000 | <http://localhost:9110> | -             |
| Blackbox Exporter | 9115 | <http://localhost:9990> | -             |

Grafana uses a custom entrypoint script to install the [GitHub Datasource Plugin](https://grafana.com/docs/plugins/grafana-github-datasource/latest) if not already installed.

### How to start the `telemetry` stack

- To start the telemetry stack, you need a GitHub Personal Access Token (classic). For required scopes, see the "Permissions" section in the [Grafana documentation](https://grafana.com/docs/plugins/grafana-github-datasource/latest/setup/token/#permissions).
- Run [the stack](components/telemetry/docker-compose.yml) using `docker compose up` in the `components/telemetry` folder.

## Stack: Metrics

The `metrics` Docker stack (see [`components/metrics`](components/metrics) folder) is a Docker Compose configuration that manages all of the needed exporters to monitor system metrics with Prometheus and Grafana. By using the`metrics` Docker stack, you can quickly and easily deploy all of the necessary components for monitoring your system metrics. This includes exporters for various system metrics, such as CPU usage, disk usage, and network activity.

| Component     | Port | URL                     |
| ------------- | ---- | ----------------------- |
| Node Exporter | 9100 | <http://localhost:9100> |
| cAdvisor      | 9110 | <http://localhost:9110> |

### How to start the `metrics` stack

- Run [the stack](components/metrics/docker-compose.yml) using `docker compose up` in the `components/metrics` folder.

## Risks and Technical Debts

All issues labeled as `risk` (= some sort of risk or a technical debt) or `security` (= disclosed security issues - e.g. CVEs) [are tracked as GitHub issue](https://github.com/sommerfeld-io/telemetry/issues?q=is%3Aissue+label%3Asecurity%2Crisk+is%3Aopen) and carry the respective label.

## Contact

Feel free to contact me via <sebastian@sommerfeld.io> or [raise an issue in this repository](https://github.com/sommerfeld-io/telemetry/issues).
