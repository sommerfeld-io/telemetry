# Stack: `metrics`

The `metrics` Docker stack is a Docker Compose configuration that manages all of the needed exporters to monitor system metrics with Prometheus and Grafana. By using the`metrics` Docker stack, you can quickly and easily deploy all of the necessary components for monitoring your system metrics. This includes exporters for various system metrics, such as CPU usage, disk usage network activity, and logs.

| Component     | Port  | URL                      |
| ------------- | ----- | ------------------------ |
| Alloy         | 12345 | <http://localhost:12345> |
| Node Exporter | 9100  | <http://localhost:9100>  |
| cAdvisor      | 9110  | <http://localhost:9110>  |

Alloy is configured to collect logs from all running Docker containers and forward them to the Loki instance running in the telemetry stack.

## How to start

Run [the stack](docker-compose.yml) using `docker compose up` in the `components/metrics` folder.

## How to run locally for development

The [telemetry stack](../telemetry/docker-compose.yml) needs an Alloy to with a special configuration to collect logs from all running Docker containers on the development host (or the dev-container) and forward them to the Loki instance running in the telemetry stack.

To achieve this, run the development Alloy config from [`docker-compose-dev.yml`](docker-compose-dev.yml) using `docker compose -f docker-compose-dev.yml up`. This Alloy instance is set up to forward logs from all running Docker containers the local Loki instance of the Telemetry stack.

| Component         | Port | URL                     |
| ----------------- | ---- | ----------------------- |
| Alloy             | 2345 | <http://localhost:2345> |

> :zap: **Note**: The development Alloy instance uses port `2345` (instead of `12345`) to avoid conflicts with Alloy instances that might be running on the host machine and provide data to the production setup.
