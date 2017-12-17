## Kubernetes Auth
Authenticate to vault with the root token
```
vault auth
```
Initialize kubernetes backend
```
vault auth-enable kubernetes
```
Create Service Account
```
kubectl apply -f serviceaccounts/vault-auth.yaml
```
Create Cluster Role Bindings
```
kubectl apply -f clusterrolebindings/vault-auth.yaml
```
Get Kubernetes host, ca.crt, and Token for vault service account
```
KUBEHOST=$(kubectl get svc kubernetes -o json | jq -r '.spec.clusterIP')
TOKEN_NAME=$(kubectl get serviceaccount vault-auth -o json | jq -r '.secrets[0].name')
kubectl get secret $TOKEN_NAME -o json | jq -r '.data["ca.crt"]' | base64 --decode > ca.crt
TOKEN=$(kubectl get secret $TOKEN_NAME -o json | jq -r '.data.token' | base64 --decode)
```
Create Vault Config for Kubernetes Authentication
```
vault write auth/kubernetes/config \
  token_reviewer_jwt=$TOKEN \
  kubernetes_host=https://$KUBEHOST \
  kubernetes_ca_cert=@ca.crt
```
Create Vault Policy
```
vault write sys/policy/demo policy=@demo.hcl
```
Create Role
```
vault write auth/kubernetes/role/demo \
  bound_service_account_names=vault-auth \
  bound_service_account_namespaces=default \
  policies=demo \
  ttl=1h
```
Create A Vault Secret
```
vault write secret/foo user=foo password=Password1!
```

[Get a Secret from Vault via a Pod](https://github.com/jsmickey/kubernetes-consul-vault/blob/master/docs/get-a-secret.md)
