#!/bin/bash

readonly PLUGINS=(
  'yesoreyeram-infinity-datasource'
  #'grafana-github-datasource'
  # Add more plugin names here
)

for plugin in "${PLUGINS[@]}"; do
  if [ ! -d "/var/lib/grafana/plugins/$plugin" ]; then
    echo "[INFO] Plugin Installation: $plugin"
    grafana-cli plugins install "$plugin"
  else
    echo "[INFO] Plugin Installation skipped (already installed): $plugin"
  fi
done

exec /run.sh "$@"
