user node[:kibana_authentication_proxy][:user] do
  system true
  home node[:kibana_authentication_proxy][:install_path]
  action :create
end

if node[:kibana_authentication_proxy][:use_authbind]
  include_recipe 'chef-sugar'
  compile_time do
    include_recipe 'authbind'
  end

  authbind_port "kibana user" do
    port node[:kibana_authentication_proxy][:listen_port]
    user node[:kibana_authentication_proxy][:user]
  end
end
