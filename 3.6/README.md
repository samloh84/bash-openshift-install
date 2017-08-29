Run the following shell script to install Openshift Origin 3.6
	
	install.sh

Default URL: https://openshiftv36.test.example.com:8443

Default Credentials:

	admin
	Pass1234

Original hosts.origin file can be found at this 
[URL](https://github.com/openshift/openshift-ansible/blob/release-3.6/inventory/byo/hosts.origin.example).
[Raw](https://raw.githubusercontent.com/openshift/openshift-ansible/release-3.6/inventory/byo/hosts.origin.example).

Be sure that your network DNS server has a wildcard entry pointing
to your Openshift Origin Master Node

E.g. (Dnsmasq)

	address=/apps.openshiftv36.test.example.com/192.168.1.36

Ensure that you have set up SSH key authentication, and that you are using 
an account that has passwordless sudo capabilities, so that Ansible may run
without problems.
