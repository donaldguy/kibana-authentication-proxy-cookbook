#<
# Start the actual proxy app running as a service, installing dependencies if
# necesarry
#>
include_recipe 'chef-sugar'

compile_time do
  include_recipe 'nodejs::npm' unless installed?('npm')
end

nodejs_npm 'kibana-authentication-proxy dependencies' do
  path node[:kibana_authentication_proxy][:install_path]
  json true
  user node[:kibana_authentication_proxy][:user]
  not_if { ::Dir.exists?("#{node[:kibana_authentication_proxy][:install_path]}/node_modules") }
end

node.default['build-essential']['compile_time'] = true
include_recipe 'build-essential'
include_recipe 'pleaserun'

#create a service file. Let pleaserun figure out what kind.
pleaserun 'kibana-authentication-proxy' do
  name 'kibana'
  program "#{which('node')}"
  args ["#{node[:kibana_authentication_proxy][:install_path]}/app.js"]
  user node[:kibana_authentication_proxy][:user]
  description 'Kibana with elasticsearch tunneling and authentication'
  action :create
end

service 'kibana' do
  action [:enable, :start]
  provider Chef::Provider::Service::Upstart if ubuntu?
end
