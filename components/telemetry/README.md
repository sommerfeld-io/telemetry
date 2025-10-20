# Stack: `telemetry`

The `telemetry` Docker stack is designed to run on a dedicated Raspberry Pi, serving as the central monitoring server for the homelab environment. The stack continuously collects, stores, and visualizes metrics from various devices and services across the network. This setup provides a solution for tracking system health, performance, and service availability in the self-hosted infrastructure.

| Component         | Port | URL                     |
| ----------------- | ---- | ----------------------- |
| Prometheus        | 9090 | <http://localhost:9090> |
| Grafana           | 3000 | <http://localhost:3000> |
| Blackbox Exporter | 9115 | <http://localhost:9115> |

## How to start

Run [the stack](docker-compose.yml) using `docker compose up` in the `components/telemetry` folder.

## How to run locally for development

**Metrics:** When running the telemetry stack locally for development, Prometheus operates as it does in production: it actively scrapes metrics from all configured targets. This means (as long as targets are exposing metrics) the local Prometheus instance collects real data from the same endpoints, allowing developers to observe and test the full metrics pipeline in a realistic environment. As a result, the development setup receives and processes actual metrics, ensuring feature parity and reliable testing.

**Logs:** For log collection during local development, the telemetry stack includes a Grafana Alloy instance in the `dev` profile which is configured for development use. Based on <https://grafana.com/docs/loki/latest/get-started/quick-start/tutorial> and <https://github.com/grafana/loki-fundamentals?tab=readme-ov-file>, this Alloy instance is set up to forward logs from all running Docker containers on the development host (or the dev-container) to the local Loki instance. The development Alloy configuration uses `localhost` as the target destination, which is separate from the production configuration.

To start the telemetry stack with metrics and logs locally for development, run `docker compose --profile=dev up` in the `components/telemetry` folder.

| Component         | Port | URL                     |
| ----------------- | ---- | ----------------------- |
| Alloy             | 2345 | <http://localhost:2345> |

> :zap: **Note**: The development Alloy instance uses port `2345` (instead of `12345`) to avoid conflicts with Alloy instances that might be running on the host machine and provide data to the production setup.

**Tests:** To run some *tests* after starting the telemetry stack, run `docker compose up` in the `tests/telemetry` folder. The goal of the tests is to verify that all services defined in the `components/telemetry/docker-compose.yml` can be started successfully in the local environment. It is not intended to audit or check the status of services running on remote machines or Raspberry Pi nodes.
