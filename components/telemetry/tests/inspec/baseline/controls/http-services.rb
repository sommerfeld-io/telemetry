title 'HTTP Service Check'

control 'http-01' do
  impact 1.0
  title 'Ensure all services are up running'
  desc 'Checks if the HTTP services are listening and are accessible'

  services = [
    { protocol: 'http', host: 'host.docker.internal', port: '3000', path: 'healthz' }, # grafana
    { protocol: 'http', host: 'host.docker.internal', port: '3100', path: 'ready' }, # loki
    { protocol: 'http', host: 'host.docker.internal', port: '9090', path: '-/healthy' }, # prometheus
    { protocol: 'http', host: 'host.docker.internal', port: '9115', path: 'metrics' }, # blackbox-exporter
  ]

  services.each do |srv|
    url = "#{srv[:protocol]}://#{srv[:host]}:#{srv[:port]}/#{srv[:path]}"

    describe host(srv[:host], port: srv[:port], protocol: srv[:protocol]) do
      it { should be_resolvable }
      its('protocol') { should eq srv[:protocol] }
    end

    describe http(url) do
      its('status') { should be_in [200, 302, 307] }
      its('headers.Content-Type') { should match(/text\/plain|html|application\/json/) }
    end
  end
end
