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

# runit scripts will go here
