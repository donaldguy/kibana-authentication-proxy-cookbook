if !node[:kibana_authentication_proxy].attribute?(:cookie_secret)
  require 'securerandom'
  random_string = SecureRandom.hex
  node.set[:kibana_authentication_proxy][:cookie_secret] = random_string
end

template "#{node[:kibana_authentication_proxy][:install_path]}/config.js" do
  variables(node[:kibana_authentication_proxy])
end
