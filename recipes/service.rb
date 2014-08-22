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

#create a upstart service file.
template '/etc/init/kibana.conf' do
  source 'upstart-kibana.conf.erb'
  variables(lazy do
    {
      user: node[:kibana_authentication_proxy][:user],
      use_authbind: node[:kibana_authentication_proxy][:use_authbind],
      authbind_path: which('authbind'),
      node_path: which('node'),
      app_js_path: "#{node[:kibana_authentication_proxy][:install_path]}/app.js"
    }
  end)
end

service 'kibana' do
  action [:enable, :start]
  provider Chef::Provider::Service::Upstart
end
