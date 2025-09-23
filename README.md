# Telemetry

A simple telemetry setup using Docker Compose. This repo provides stacks to run Prometheus, Loki and Grafana and to expose metrics.

![Project Logo](https://raw.githubusercontent.com/sommerfeld-io/telemetry/refs/heads/main/.assets/logo.png)

## Warning: This setup is intended for our infrastructure

Feel free to use this repository as a starting point for your own configuration. However, this config references hosts and servers by name. So simply starting the services will not work for you. You need to adjust at least the host names of the machines you want to observe.

## Stack: `telemetry`

The `telemetry` Docker stack (see [`components/telemetry`](components/metrics) folder) is designed to run on a dedicated Raspberry Pi, serving as the central monitoring server for the homelab environment. The stack continuously collects, stores, and visualizes metrics from various devices and services across the network. This setup provides a solution for tracking system health, performance, and service availability in the self-hosted infrastructure.

| Component         | Port | URL                     |
| ----------------- | ---- | ----------------------- |
| Prometheus        | 9090 | <http://localhost:9090> |
| Grafana           | 3000 | <http://localhost:3000> |
| Blackbox Exporter | 9115 | <http://localhost:9115> |

### How to start the `telemetry` stack

Run [the stack](components/telemetry/docker-compose.yml) using `docker compose up` in the `components/telemetry` folder.

### How to run locally for development

When running the telemetry stack locally for development, Prometheus operates as it does in production: it actively scrapes metrics from all configured targets. This means the local Prometheus instance collects real data from the same endpoints, allowing developers to observe and test the full metrics pipeline in a realistic environment. As a result, the development setup receives and processes actual metrics, ensuring feature parity and reliable testing.

As long as the metrics stack is running, there is no need to start an additional metrics stack for local development. The local Prometheus instance will automatically scrape and collect the metrics data.

So simply start the docker compose stack as mentioned above.

## Stack: `metrics`

The `metrics` Docker stack (see [`components/metrics`](components/metrics) folder) is a Docker Compose configuration that manages all of the needed exporters to monitor system metrics with Prometheus and Grafana. By using the`metrics` Docker stack, you can quickly and easily deploy all of the necessary components for monitoring your system metrics. This includes exporters for various system metrics, such as CPU usage, disk usage network activity, and logs.

| Component     | Port  | URL                      |
| ------------- | ----- | ------------------------ |
| Alloy         | 12345 | <http://localhost:12345> |
| Node Exporter | 9100  | <http://localhost:9100>  |
| cAdvisor      | 9110  | <http://localhost:9110>  |

Alloy is configured to collect logs from all running Docker containers and forward them to the Loki instance running in the telemetry stack.

### How to start the `metrics` stack

Run [the stack](components/metrics/docker-compose.yml) using `docker compose up` in the `components/metrics` folder.

## Stack: `test-logs`

The `test-logs` Docker stack (see [`components/test-logs`](components/test-logs) folder) is designed for local development purposes to collect and forward logs from all running Docker containers to Loki. Unlike Prometheus, which scrapes metrics from endpoints, Loki does not actively scrape log data. Instead, this stack uses Grafana Alloy to collect container logs and push them to the Loki instance running in the telemetry stack.

| Component | Port | URL                     |
| --------- | ---- | ----------------------- |
| Alloy     | 2345 | <http://localhost:2345> |

> :zap: Note: The `test-logs` stack uses a non-standard port (`2345` instead of `12345`) to avoid conflicts with alloy instances that might be running on the host machine.

The Alloy agent monitors the Docker socket (`/var/run/docker.sock`) to capture logs from all local containers and forwards them to Loki for centralized log aggregation and analysis. This setup enables developers to test log collection and visualization workflows locally without impacting production systems.

### How to start the `test-logs` stack

Run [the stack](components/test-logs/docker-compose.yml) using `docker compose up` in the `components/test-logs` folder. You can run the stack from inside a DevContainer as well.

## Risks and Technical Debts

All issues labeled as `risk` (= some sort of risk or a technical debt) or `security` (= disclosed security issues - e.g. CVEs) [are tracked as GitHub issue](https://github.com/sommerfeld-io/telemetry/issues?q=is%3Aissue+label%3Asecurity%2Crisk+is%3Aopen) and carry the respective label.

## Contact

Feel free to contact me via <sebastian@sommerfeld.io> or [raise an issue in this repository](https://github.com/sommerfeld-io/telemetry/issues).
