#####
# These attributes pretty much feed through straight to the config file and
# mirror the defaults therein
#
# They should be pretty self-explanitory but if not, I left the comments in
# the template. look there
#
default[:kibana_authentication_proxy][:elasticsearch][:host] = "localhost"
default[:kibana_authentication_proxy][:elasticsearch][:port] = 9200
default[:kibana_authentication_proxy][:elasticsearch][:ssl] = false
default[:kibana_authentication_proxy][:elasticsearch][:basic_auth_username] = ""
default[:kibana_authentication_proxy][:elasticsearch][:basic_auth_password] = ""

default[:kibana_authentication_proxy][:listen_port] = 9201

default[:kibana_authentication_proxy][:browser_cache_max_age] = 0

default[:kibana_authentication_proxy][:ssl][:enable] = false
default[:kibana_authentication_proxy][:ssl][:listen_port] = 4443
default[:kibana_authentication_proxy][:ssl][:key_file_path] = "POINT_TO_YOUR_SSL_KEY"
default[:kibana_authentication_proxy][:ssl][:cert_file_path] = "POINT_TO_YOUR_SSL_CERT"

default[:kibana_authentication_proxy][:kibana_dashboards][:elasticsearch_index] = "kibana-int"
default[:kibana_authentication_proxy][:kibana_dashboards][:auth_type] = "cas"

default[:kibana_authentication_proxy][:google_oauth][:enable] = false
default[:kibana_authentication_proxy][:google_oauth][:client_id] = ""
default[:kibana_authentication_proxy][:google_oauth][:client_secret] = ""
default[:kibana_authentication_proxy][:google_oauth][:allowed_emails] = ["*"]

default[:kibana_authentication_proxy][:basic_auth][:enable] = false
default[:kibana_authentication_proxy][:basic_auth][:users] = [{user:"demo1",password:"pwd1"},{user:"demo1",password:"pwd2"}]

default[:kibana_authentication_proxy][:cas_auth][:enable] = false
default[:kibana_authentication_proxy][:cas_auth][:server_url] = "https://point-to-the-cas-server/cas"
default[:kibana_authentication_proxy][:cas_auth][:protocol_version] = 1
