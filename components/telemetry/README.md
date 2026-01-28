# Stack: `telemetry`

The `telemetry` Docker stack is designed to run on a dedicated Raspberry Pi, serving as the central monitoring server for the homelab environment. The stack continuously collects, stores, and visualizes metrics from various devices and services across the network. This setup provides a solution for tracking system health, performance, and service availability in the self-hosted infrastructure.

| Component         | Port | URL                     |
| ----------------- | ---- | ----------------------- |
| Prometheus        | 9090 | <http://localhost:9090> |
| Grafana           | 3000 | <http://localhost:3000> |
| Loki              | 3100 | <http://localhost:3100> |
| Blackbox Exporter | 9115 | <http://localhost:9115> |
| GitHub Exporter   | 9171 | <http://localhost:9171> |

## How to start

Run [the stack](docker-compose.yml) using `docker compose up` in the `components/telemetry` folder.

## How to run locally for development

**Metrics:** When running the telemetry stack locally for development, Prometheus operates as it does in production: it actively scrapes metrics from all configured targets. This means (as long as targets are exposing metrics) the local Prometheus instance collects real data from the same endpoints, allowing developers to observe and test the full metrics pipeline in a realistic environment. As a result, the development setup receives and processes actual metrics, ensuring feature parity and reliable testing.

**Logs:** For log collection during local development, run the development Alloy config from [`components/metrics-dev/docker-compose.yml`](../metrics-dev/docker-compose.yml). The development Alloy instance is set up to forward logs from all running Docker containers on the development host (or the dev-container) to this local Loki instance. The development Alloy configuration uses `localhost` as the target destination, which is separate from the production configuration.

**Tests:** To run some tests after starting the telemetry stack, run `docker compose up` in the `tests/telemetry` folder. The goal of the tests is to verify that all services defined in the `components/telemetry/docker-compose.yml` can be started successfully in the local environment. It is not intended to audit or check the status of services running on remote machines or Raspberry Pi nodes.

## Collecting GitHub Metrics

The [`github-exporter`](https://github.com/githubexporter/github-exporter) provides metrics about GitHub repositories.

Compared to the [GitHub datasource](https://github.com/grafana/github-datasource) the `github-exporter` provides less metrics and does not offer any data about Actions workflows.

The advantage of the `github-exporter` is that it queries the GitHub API according to the Prometheus scrape interval and that the data is stored in the local Prometheus. The GitHub datasource queries the GitHub API on every dashboard load which could lead to rate limiting issues when querying often and results in a less smooth user experience due to loading delays.

> **:zap: CAUTION:** GitHub enforces a strict rate limit on its metrics endpoint. So running the `github-exporter` with not Personal Access Token (PAT) might quickly lead to being rate limited and no metrics being collected.
>
> But since we are only evaluating the `github-exporter` we try anonymous access without a PAT. This way we do not need to worry about leaking any secrets in the public repository or about rolling out a token to the `admin-pi` through assible.
>
> In case a token is needed, the scopes `public_repo`, `read:org` and `read:user` should be sufficient.
