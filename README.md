# Flynn Deploy for Wercker

Deploys a package from wercker to Flynn via git push interface. 
https://flynn.io/docs/cli


You must set your keys in the wercker deploy variable page.

## Options


* 'flynn_tlspin' (required) The certificate pin.
* 'flynn_cluster_domain' (required) Should be https://controller.$CLUSTER_DOMAIN
* 'flynn_controller_key' (required) The controller authentication key.
* 'flynn_app_name' (required) A name you want to refer to the cluster by locally.

## Example

    - flynn-push:
        flynn_tlspin: $FLYNN_TLSPIN
        flynn_cluster_domain: $FLYNN_CLUSTER_DOMAIN
        flynn_controller_key: $FLYNN_CONTROLLER_KEY
        flynn_app_name: $FLYNN_APP_NAME
