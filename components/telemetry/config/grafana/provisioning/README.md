# A word about provisioning

We don't need a provider configuration file for alerts! Alert provisioning works differently than dashboard provisioning in Grafana.

- Dashboards require a provider config file that tells Grafana where to look for dashboard JSON files.
- Alerts are provisioned directly through YAML files in the /etc/grafana/provisioning/alerting/ directory without needing a separate provider configuration. Further sub-folders seem to not be supported.

## See also

- Use configuration files to provision alerting resources: <https://grafana.com/docs/grafana/latest/alerting/set-up/provision-alerting-resources/file-provisioning/>
