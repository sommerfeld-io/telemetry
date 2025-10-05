title 'Services Check'

services = [
  { host: 'host.docker.internal', port: '3000', path: 'healthz', container: 'grafana' },
  { host: 'host.docker.internal', port: '3100', path: 'ready', container: 'loki' },
  { host: 'host.docker.internal', port: '9090', path: '-/healthy', container: 'prometheus' },
  { host: 'host.docker.internal', port: '9115', path: 'metrics', container: 'blackbox_exporter' },
]
protocol = 'http'

control 'http-01' do
  impact 1.0
  title 'Ensure all services are up running'
  desc 'Checks if the HTTP services are listening and are accessible'

  services.each do |srv|
    url = "#{protocol}://#{srv[:host]}:#{srv[:port]}/#{srv[:path]}"

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

# control 'container-01' do
#   impact 1.0
#   title 'Ensure all containers are up running'
#   desc 'Checks if the HTTP services are listening and are accessible'

#   services.each do |srv|
#     describe docker_container(srv[:container]) do
#       it { should exist }
#       it { should be_running }
#     end
#   end
# end

# control 'grafana-01' do
#   impact 1.0
#   title 'Ensure grafana is correctly configured'
#   desc 'Validates the environment variables for grafana'

#   describe docker_container('grafana') do
#     its('config.Env') { should include 'GF_SECURITY_ADMIN_USER=admin' }
#     its('config.Env') { should include 'GF_SECURITY_ADMIN_PASSWORD=admin' }
#   end
# end
