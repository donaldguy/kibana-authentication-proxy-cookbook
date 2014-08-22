# kibana-authentication-proxy Cookbook <br>(Upstart Edition)

Installs [fangli/kibana-authentication-proxy](https://github.com/fangli/kibana-authentication-proxy). And gets it running under upstart with
a service file `/etc/init/kibana.conf`

## Supported Platforms

Tested on Ubuntu 14.04. Should hypothetically be fine on anything supported by
dependencies.

## Usage

### kibana-authentication-proxy::default

Include `kibana-authentication-proxy` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[kibana-authentication-proxy]"
  ]
}
```

If using Google OAuth, you need to set-up the callback URL. It will look like `http://YOUR-KIBANA-SITE:[listen_port]/auth/google/callback`

## Install-time Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[:kibana-authentication-proxy][:install_path]</tt></td>
    <td>String</td>
    <td>where to install</td>
    <td><tt>/opt/kibana-authentication-proxy</tt></td>
  </tr>
  <tr>
    <td><tt>[:kibana-authentication-proxy][:git_ref]</tt></td>
    <td>String</td>
    <td>The ref to checkout from github. At last testing time, the current head of master
    was 0c0173b0cb51b392b7fc04d0cc728ffb64671ef3</td>
    <td><tt>master</tt></td>
  </tr>
  <tr>
    <td><tt>[:kibana_authentication_proxy][:user]</tt></td>
    <td>String</td>
    <td>User to run the node proxy app as. Will create if necessary</td>
    <td><tt>kibana</tt></td>
  <tr>
    <td><tt>[:kibana-authentication-proxy][:kibana_git_ref]</tt></td>
    <td>String</td>
    <td>the kibana-authentication-proxy README currently "optionally" suggests
     updating the submoduled kibana beyond its saved state. If you'd like to
    do that, set this to 'master' (or whatever ref you prefer)</td>
    <td><tt>:from_proxy_repo</tt></td>
  </tr>
  <tr>
    <td><tt>[:kibana-authentication-proxy][:use_authbind]</tt></td>
    <td>Boolean</td>
    <td>If you want to run on a low-port (e.g. 80), but don't want to run node
    as root (and you shouldn't), set this to true to install and use [authbind](http://en.wikipedia.org/wiki/Authbind)</td>
    <td><tt>false</tt></td>
  </tr>
</table>

## Configuration-time Attributes
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:elasticsearch][:host]</tt></td>
  	<td>String</td>
    <td>The host of the ElasticSearch server</td>
  	<td><tt> "localhost"</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:elasticsearch][:port]</tt></td>
  	<td>Integer</td>
  	<td>The port of the ElasticSearch server</td>
  	<td><tt> 9200</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:elasticsearch][:ssl]</tt></td>
  	<td>Boolean</td>
  	<td>Is the ElasticSearch server using SSL (https)?</td>
  	<td><tt>false</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:elasticsearch][:basic_auth_username]</tt></td>
  	<td>String</td>
    <td>The basic authentication user of ES server, leave it blank if no basic auth applied</td>
  	<td><tt>""</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:elasticsearch][:basic_auth_password]</tt></td>
  	<td>String</td>
  	<td>The basic authentication user of ES server, leave it blank if no basic auth applied</td>
  	<td><tt>""</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:listen_port]</tt></td>
  	<td>Integer</td>
  	<td>The port on which the kibana proxy should listen</td>
  	<td><tt>9201</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:browser_cache_max_age]</tt></td>
  	<td>Integer</td>
  	<td>HTTP max-Age header, set high to cache more and load faster</td>
  	<td><tt>0</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:ssl][:enable]</tt></td>
  	<td>Boolean</td>
  	<td>Listen with HTTPS?</td>
  	<td><tt> false</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:ssl][:listen_port]</tt></td>
  	<td>port</td>
  	<td>If so, on what port?</td>
  	<td><tt> 4443</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:ssl][:key_file_path]</tt></td>
  	<td>String</td>
  	<td>Absolute path to SSL key</td>
  	<td><tt>"POINT_TO_YOUR_SSL_KEY"</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:ssl][:cert_file_path]</tt></td>
  	<td>String</td>
    <td>Absolute path to SSL certificate</td>
  	<td><tt>"POINT_TO_YOUR_SSL_CERT"</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:kibana_dashboards][:elasticsearch_index]</tt></td>
  	<td>String</td>
  	<td>The ElasticSearch index in which to save dashboards. Use %user% for a per-user index</td>
  	<td><tt> "kibana-int"</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:kibana_dashboards][:auth_type]</tt></td>
  	<td>Enum {google, cas or basic}</td>
  	<td>What auth method to derive %user% from</td>
  	<td><tt>"cas"</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:google_oauth][:enable]</tt></td>
  	<td>Boolean</td>
  	<td>Enable Google Oauth</td>
  	<td><tt> false</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:google_oauth][:client_id]</tt></td>
  	<td>String</td>
  	<td>Ouath2 client id</td>
  	<td><tt> ""</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:google_oauth][:client_secret]</tt></td>
  	<td>String</td>
  	<td>Oauth2 client secret</td>
  	<td><tt> ""</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:google_oauth][:allowed_emails]</tt></td>
  	<td>Array of Strings</td>
  	<td> An emails list for the authorized users, should like `["a@b.com", "@b.com"]`</td>
  	<td><tt>["*"]</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:basic_auth][:enable]</tt></td>
  	<td>Boolean</td>
  	<td>Enable basic auth?</td>
  	<td><tt> false</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:basic_auth][:users]</tt></td>
  	<td>Array of hashes</td>
  	<td>Plaintext users and passwords as values with keys :user and :password, respectively</td>
  	<td><tt>[{user:"demo1",password:"pwd1"},{user:"demo1",password:"pwd2"}]</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:cas_auth][:enable]</tt></td>
  	<td>Boolean</td>
  	<td>Use CAS auth?</td>
  	<td><tt> false</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:cas_auth][:server_url]</tt></td>
  	<td>URL</td>
  	<td>path to CAS server</td>
  	<td><tt> "https://point-to-the-cas-server/cas"</tt></td>
  </tr>
  <tr>
  	<td><tt>[:kibana_authentication_proxy][:cas_auth][:protocol_version]</tt></td>
  	<td>1 or 2</td>
  	<td>CAS version</td>
  	<td><tt>1</tt></td>
  </tr>
</table>

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Donald Guy:: Crowdtap, Inc. (<donaldg@crowdtap.com>)
