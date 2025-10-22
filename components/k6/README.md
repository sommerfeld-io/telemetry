# Stack: `k6`

This stack runs load tests with [Grafana k6](https://k6.io) against specified services. It provides a containerized environment for performance testing with configurable targets and test parameters.

| Component         | Port | URL                     | Note                                                |
| ----------------- | ---- | ----------------------- | --------------------------------------------------- |
| system-under-test | 8080 | <http://localhost:8080> | Spring PetClinic application as default test target |
| sleeper           | -    | -                       | Configurable startup delay before the tests begin   |
| k6-runner         | -    | -                       | Executes (load) tests using Grafana k6              |

> **:zap: Note**: At the moment the stack expects a Spring PetClinic application as the system under test.

## How to start

Run [the stack](docker-compose.yml) using `docker compose up` in the `components/k6` folder.

## How to run locally for development

To run the stack in a development setup, use the following command:

```bash
docker-compose -f docker-compose.yml -f docker-compose-dev.yml up
```

This starts a `system-under-test` service along with the `k6-runner` and `sleeper` services, allowing you to test against a local instance of the Spring PetClinic application.
