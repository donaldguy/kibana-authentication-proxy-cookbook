#
# Cookbook Name:: kibana-authentication-proxy
# Recipe:: default
#
# Copyright (C) 2014 Crowdtap, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

include_recipe 'chef-sugar'

compile_time do
  include_recipe 'git' unless installed?('git')
  include_recipe 'nodejs::npm' unless installed?('npm')
end

git node[:kibana_authentication_proxy][:install_path] do
  repository "https://github.com/fangli/kibana-authentication-proxy.git"
  enable_submodules true
  revision node[:kibana_authentication_proxy][:git_ref]

  notifies :install, "nodejs_npm[kibana-authentication-proxy]", :immediately
end

if node[:kibana_authentication_proxy][:kibana_git_ref]
  git "#{node[:kibana_authentication_proxy][:install_path]}/kibana" do
    revision node[:kibana_authentication_proxy][:kibana_git_ref]
    repository "https://github.com/elasticsearch/kibana.git"
  end
end

nodejs_npm 'kibana-authentication-proxy' do
  path node[:kibana_authentication_proxy][:install_path]
  json true
  action :nothing #notified when repo updates
end

if !node[:kibana_authentication_proxy].attribute?(:cookie_secret)
  require 'securerandom'
  random_string = SecureRandom.hex
  node.set[:kibana_authentication_proxy][:cookie_secret] = random_string
end

template "#{node[:kibana_authentication_proxy][:install_path]}/config.js" do
  variables(node[:kibana_authentication_proxy])
end
