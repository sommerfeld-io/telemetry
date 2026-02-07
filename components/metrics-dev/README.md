# Stack: `metrics-dev`

The [telemetry stack](../telemetry/docker-compose.yml) needs an Alloy to with a certain configuration to collect logs from all running Docker containers on the development host (or the dev-container) and forward them to the Loki instance running in the telemetry stack.

The "real" Alloy config pushes data to the telemetry stack which is running on the `admin-pi`. But when developing locally, we need to ship data to the local telemetry stack instance.

To achieve this, run this development Alloy config from [`docker-compose.yml`](docker-compose.yml). This Alloy instance is set up to forward logs from all running Docker containers the local Loki instance.

| Component         | Port | URL                     | Info                                                                      |
| ----------------- | ---- | ----------------------- | ------------------------------------------------------------------------- |
| Alloy             | 2345 | <http://localhost:2345> | Different port to avoid conflicts with "real" Alloy instances on the host |

> :zap: **Note**: The development Alloy instance uses port `2345` (instead of `12345` or `12346`) to avoid conflicts with Alloy instances that might be running on the host machine and provide data to the production setup.
