#!/bin/bash

if [ ! -d "/var/lib/grafana/plugins/grafana-github-datasource" ]; then
  echo "Installing Plugin: grafana-github-datasource"
  grafana-cli plugins install grafana-github-datasource
else
  echo "Installing Plugin skipped (already installed): grafana-github-datasource"
fi

# Run Grafana's default entrypoint
exec /run.sh "$@"
