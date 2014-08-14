default[:kibana_authentication_proxy][:install_path] = '/opt/kibana-authentication-proxy'

#<
# The ref to checkout from github. At last testing tmime, the current head of master
# was 0c0173b0cb51b392b7fc04d0cc728ffb64671ef3
#>
default[:kibana_authentication_proxy][:git_ref] = 'master'

#<
#  the kibana-authentication-proxy README currently "optionally" suggests
#  updating the submoduled kibana beyond its saved state. If you'd like to
#  do that, set this to 'master' (or whatever ref you prefer)
#>
default[:kibana_authentication_proxy][:kibana_git_ref] = false
