# Sample Terraform web site deployment for IBM Cloud IaaS

steve_strutt@uk.ibm.com
Licensed under the Apache License, Version 2.0 (the "License");

Demo Terraform configuration to deploy the IBM Cloud IaaS infrastructure for a secure and scalable Wordpress implementation, based on 
 - IBM Cloud Load Balancer
 - Virtual Machines
 - Security Groups
 - httpd app server
 - mariadb 

This is written as a capability demonstration of deploying web sites using Terraform on IBM Cloud IaaS.   


<p style="text-align: center;">
  <img src="images/WordpressCLB.png" alt="CLB single site" width="500"/>
</p>

## Costs

This sample uses hourly chargable services. Deploying this sample will cost in the region of a few cents per hour. Destroying the configuration, will result in no further costs being incurred. 

A registered DNS domain name and SSL/TLS certificate are not required. 


## DNS propagation

DNS name updates for the load-balancer can take anywhere from 10 to 30 minutes to propagate to global nameservers after this configuration is applied. The public IP address of the load balancer is available from the SoftLayer name servers at ns1.softlayer.com and ns2.softlayer.com within minutes of execution and can be used to validate successful setup of the load balancers and VMs. 

The assigned public DNS name for the load balancer will be output at the end of the terraform apply command. Illustrated here:

```
Apply complete! Resources: 17 added, 0 changed, 0 destroyed.
Outputs:
web_dns_name = http://web-lb-1530547-lon06.lb.bluemix.net
```

Perform a DNS lookup with nslookup using <web_dsn_name>  

`nslookup <web_dns_name> ns1.softlayer.com`

```
nslookup web-lb-1530547-lon06.lb.bluemix.net ns1.softlayer.com 
Server:     ns1.softlayer.com
Address:    67.228.254.4#53

Name:   web-lb-1530547-lon06.lb.bluemix.net
Address: 158.176.91.245
Name:   web-lb-1530547-lon06.lb.bluemix.net
Address: 158.176.72.23
```

Either of the two listed 'Addresses:' <address> for 'Name:' <web_dsn_name> can be used to validate that the a basic Apache web server is accessible via the load balancer

Run curl with <adddress> to return Apache splash page.  
`curl <address> -vS` 

```
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"><html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <title>Apache HTTP Server Test Page powered by CentOS</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

```


## Dependencies

- User has sufficient security rights to create VMs, Security Groups and Loadbalancer 
- User VPN to the IaaS platform has been configured.
- SSL key for remote user access to VMs

There is no dependancy on existing networking configuration or firewalls, domain names or SSL/TLS certificates. A dns domain name is dynamically allocated by IBM Cloud to the Cloud Load Balancer. No user registered domain name is required. 


## Configuration 

The following variables need to be set in the terraform.tf file before use

- iaas_username is a Infrastructure user name. Go to https://control.bluemix.net/account/user/profile, scroll down, and check API Username.
- ibmcloud_iaas_api_key is a Infrastructure API Key. Go to https://control.bluemix.net/account/user/profile, scroll down, and check Authentication Key.
- ibmcloud_api_key - An API key for IBM Cloud services. If you don't have one already, go to https://console.bluemix.net/iam/#/apikeys and create a new key.
