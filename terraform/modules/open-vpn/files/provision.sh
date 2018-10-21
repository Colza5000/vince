#!/usr/bin/env bash

/usr/local/openvpn_as/scripts/sacli --key vpn.client.tls_version_min --value 1.2 ConfigPut

/usr/local/openvpn_as/scripts/sacli --key vpn.client.tls_version_min_strict --value true ConfigPut

/usr/local/openvpn_as/scripts/sacli --key vpn.server.tls_version_min --value 1.2 ConfigPut

/usr/local/openvpn_as/scripts/sacli --key cs.tls_version_min --value 1.2 ConfigPut

/usr/local/openvpn_as/scripts/sacli --key cs.tls_version_min_strict --value true ConfigPut

# OpenVPN AS supported ciphers listed here: https://openvpn.net/index.php/access-server/docs/admin-guides/437-how-to-change-the-cipher-in-openvpn-access-server.html
/usr/local/openvpn_as/scripts/sacli --key vpn.client.config_text --value 'cipher AES-256-CBC' ConfigPut

/usr/local/openvpn_as/scripts/sacli --key vpn.server.config_text --value 'cipher AES-256-CBC' ConfigPut

# Changes require a restart.
/usr/local/openvpn_as/scripts/sacli start

# This is where the Parameter Store secure string is passed and changes the insecure 'ChangeMePlease' default password. 
# However, if using a default SSM KMS key the instance role and IAM action get-parameters will allow decryption of the secure string so either remove SSH access and/or remove the IAM policy action.
/usr/local/openvpn_as/scripts/ovpnpasswd -u $USER -p $PASS
   