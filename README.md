## Hashicorp Vault on Kubernetes
 - Vault https://www.vaultproject.io/
 - Consul https://www.consul.io/
 - Kubernetes https://kubernetes.io/

Kelsey's Hightower's [Consul-On-Kubernetes](https://github.com/kelseyhightower/consul-on-kubernetes) was used to start this project.  I have built on top of his work and give him credit for getting started.
<br>
After getting Vault running, I found this [nomad-on-kubernetes](https://github.com/kelseyhightower/nomad-on-kubernetes) which includes Vault.  My steps do not include node affinity for Vault which is recommended for production. <br>
This project uses GKE and GCP, but is not required <br>

#### Prerequisites
 - Kubernetes Cluster</br>
 - Docker Register</br>
 - Cloudflare's [cfssl and cfssljson](https://github.com/cloudflare/cfssl)</br>
 - Consul binary</br>
 - Vault binary</br>

#### Links
https://github.com/drud/vault-consul-on-kube</br>
https://www.consul.io/docs/guides/acl.html</br>
https://github.com/arun-gupta/vault-kubernetes</br>

[Setup and Configure Consul](https://github.com/jsmickey/kubernetes-consul-vault/blob/master/docs/consul.md)
[Setup and Configure Vault](https://github.com/jsmickey/kubernetes-consul-vault/blob/master/docs/vault.md)
[Setup and Configure Vault Kubernetes Auth Backend](https://github.com/jsmickey/kubernetes-consul-vault/blob/master/docs/kubernetes-auth.md)
[Get a Secret from Vault via a Pod](https://github.com/jsmickey/kubernetes-consul-vault/blob/master/docs/get-a-secred.md)
