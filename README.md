# IBM Watsonx Discovery - Kibana Installation Toolkit
<img src=".img/k6.png" alt="Openshift Kibana Running - Runs" width="200" height="80">  <img src=".img/k14.png" alt="Openshift Kibana Running - Runs" width="200" height="80">   <img src=".img/k17.jpg" alt="Openshift Kibana Running - Runs" width="180" height="80"> <img src=".img/k18.png" alt="Openshift Kibana Running - Runs" width="100" height="80">

## Purpose
This tool provides algorithms and configuration files for the installation & deployment of [IBM Watsonx Discovery](https://cloud.ibm.com/databases/databases-for-elasticsearch/create) local Kibana on your machine and on the Redhat OpenShift Container Platform. It also supports Kibana deployment on custom OpenShift flavor. IBM Watsonx Discovery is an Index Engine for Watsonx solutions. Click here -> [Kibana Local Setup](/local) for local install & Click here -> [Kibana OpenShift Deployment](/openshift) for OpenShift deployment. 
 
## Kibana Configuration

The table 1.0.0 below provides the configuration variables required for the deployment of Kibana locallt and on OpenShift. Each variable has specific requirements as outlined below. So, before you start, head back to Watsonx Discovery UI to get all the required information in Table 1.0.0.

Table 1.0.0:  OpenShift Configmap and .Env Requirements
| Variable Name                     | Requirements                                                                         |
|-----------------------------------|--------------------------------------------------------------------------------------|
| ELASTICSEARCH_ENDPOINT            | <required - provide value as https://USERNAME:PASSWORD@HOST_without_https://>        |
| ELASTICSEARCH_USERNAME            | <required - provide value>                                                           |
| ELASTICSEARCH_PASSWORD            | <required - provide value>                                                           |
| ELASTICSEARCH_HOST                | <required - provide value without https://>                                          |
| ELASTICSEARCH_PORT                | <required - provide value>                                                           |
| ELASTICSEARCH_TLS_NAME            | <required - provide value>                                                           |
| ELASTICSEARCH_VERSION             | <required - provide value - format 0.0.0>                                            |
| ELASTICSEARCH_SSL_VERIFICATIONMODE| <required - provide value - options: full, none, certificate >                       |

## Options

### 1. [Kibana Local Setup](/local)
    -- If you choose Option-1: This will check for full valid elasticsearch certificate.
    -- If you choose Option-2: This will not check for elasticsearch certicate.

![Local Kibana Running - Prompt](.img/k1.png)

![Local Kibana Running - Complete](.img/k2.png)

![Local Kibana Running - Runs](.img/k3.png)


### 2. [Kibana OpenShift Deployment](/openshift)
```sh
Get your Kibana OpenShift URL from your project named "elk":
oc login --token=xxxxxxxx --server=xxxxxxxxxxxxxxx
echo "https://$(oc get route kibana -n elk --template='{{ .spec.host }}')"
```
```sh
Your Result:
https://kibana-yourproject.apps.yourdomain.yourtld
```

![Openshift Kibana Running - Runs](.img/k4.png)

<br><br>
Author: <br>
Jeffrey Chijioke-Uche, Ph.D<br>
IBM Hybridcloud,Multicloud, & AI

