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
default[:kibana_authentication_proxy][:kibana_git_ref] = :from_proxy_repo

#<
#  The user to run kibana as, will create if necesarry
#>
default[:kibana_authentication_proxy][:user] = 'kibana'

#<
# Generally, its nice for a proces to run itself :D
#>
default[:kibana_authentication_proxy][:use_runit] = true

#<
# We may want to bind a privilledged port (i.e. 80). We probably don't want
# to run as a privilledged user or set a cability on the node processs as
# a whole. "LD_PRELOAD to the rescue". Setting this to true will grant the
# specified user rights on the specified port
#>
default[:kibana_authentication_proxy][:use_authbind] = false
