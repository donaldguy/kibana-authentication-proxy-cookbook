kibana_user = node[:kibana_authentication_proxy][:user]

user kibana_user do
  system true
  home node[:kibana_authentication_proxy][:install_path]
  action :create
end

if node[:kibana_authentication_proxy][:use_authbind]
  include_recipe 'chef-sugar'
  compile_time do
    include_recipe 'authbind'
  end

  port_to_grant = node[:kibana_authentication_proxy][:listen_port]
  authbind_port "#{kibana_user} can bind #{port_to_grant}" do
    port port_to_grant
    user kibana_user
  end
end
