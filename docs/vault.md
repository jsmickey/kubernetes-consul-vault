## Vault
Create Vault LoadBalancer
```
kubectl apply -f services/vault.yaml
```
Fetch external IP address assigned to the load balancer
```
VAULT_EXTERNAL_IP=$(kubectl get svc vault -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
```
Create Certificates
```
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca/ca-config.json \
  -hostname="vault,vault.default.svc.cluster.local,localhost,vault.dc1.consul,vault.service.consul,127.0.0.1,${VAULT_EXTERNAL_IP}" \
  -profile=default ca/vault-csr.json | cfssljson -bare vault
```
Create Secret
 - Update VAULT_CONSUL_TOKEN in secrets/vault-server.json
```
kubectl create secret generic vault \
  --from-file=vault.pem \
  --from-file=vault-key.pem \
  --from-file=secrets/vault-server.json
```
Create StatefulSet
```
kubectl apply -f statefulsets/vault.yaml
```
Initialize the server and follow the instructions
```
export VAULT_ADDR="https://${VAULT_EXTERNAL_IP}:8200"
export VAULT_CACERT="ca.pem"
export VAULT_CLIENT_CERT="vault.pem"
export VAULT_CLIENT_KEY="vault-key.pem"

vault init
vault unseal
vault status
```

[Setup and Configure Vault Kubernetes Auth Backend](https://github.com/jsmickey/kubernetes-consul-vault/blob/master/docs/kubernetes-auth.md)
