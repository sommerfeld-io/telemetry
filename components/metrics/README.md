# Stack: `metrics`

The `metrics` Docker stack is a Docker Compose configuration that manages all of the needed exporters to monitor system metrics with Prometheus and Grafana. By using the`metrics` Docker stack, you can quickly and easily deploy all of the necessary components for monitoring your system metrics. This includes exporters for various system metrics, such as CPU usage, disk usage network activity, and logs.

| Component     | Port  | URL                      |
| ------------- | ----- | ------------------------ |
| Alloy         | 12346 | <http://localhost:12346> |
| Node Exporter | 9100  | <http://localhost:9100>  |
| cAdvisor      | 9110  | <http://localhost:9110>  |

Alloy is configured to collect logs from all running Docker containers and forward them to the Loki instance running in the telemetry stack.

## How to start

Run [the stack](docker-compose.yml) using `docker compose up` in the `components/metrics` folder.
