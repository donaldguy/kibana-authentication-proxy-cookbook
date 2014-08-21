include_recipe 'chef-sugar'

compile_time do
  include_recipe 'git' unless installed?('git')
end

user_repo_owner = node[:kibana_authentication_proxy][:user]

#since we may be using a path where only root can create directory,
#we need to create the target for the deprivilledged user to clone into
directory node[:kibana_authentication_proxy][:install_path] do
  owner user_repo_owner
end

git node[:kibana_authentication_proxy][:install_path] do
  repository "https://github.com/fangli/kibana-authentication-proxy"
  enable_submodules true
  revision node[:kibana_authentication_proxy][:git_ref]

  user user_repo_owner
end

# clear out the node modules if requirenments might have changed in git
directory "#{node[:kibana_authentication_proxy][:install_path]}/node_modules" do
  action :nothing
  recursive true
  subscribes :delete, "git[#{node[:kibana_authentication_proxy][:install_path]}]", :immediately
end

# The repo packs in kibana as a submodule. The README suggests you may or may
# not want to update that repo to master. If a ref is specified in the
# attributes we do that here.
unless node.deep_fetch('kibana_authentication_proxy','kibana_git_ref') == :from_proxy_repo # ~FC023
  git "#{node[:kibana_authentication_proxy][:install_path]}/kibana" do
    revision node[:kibana_authentication_proxy][:kibana_git_ref]
    repository "https://github.com/elasticsearch/kibana.git"

    user user_repo_owner
  end
end
