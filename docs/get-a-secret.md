## Get A Secret
Build and Upload a Docker Container
```
docker build . -t vault-demo:<version> -t gcr.io/<gcp_project>/vault-demo:<version>
gcloud docker -- push gcr.io/<gcp_project>/vault-demo:<version>
```
Update GCP Project and Version in deployments/vault-auth.yaml<br>

Create Secret for Vault-Demo
```
kubectl create secret generic vault-demo \
  --from-literal="vault_addr=https://${VAULT_EXTERNAL_IP}:8200" \
  --from-file=vault.pem \
  --from-file=vault-key.pem \
  --from-file=ca.pem
```
Deploy Vault-Demo Pod
```
kubectl apply -f deployments/vault-demo.yaml
```
Connect to the Pod
```
kubectl get pods
kubectl exec -it <pod_name> -- bash
```
Fetch a Vault Token
```
JWT=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
vault write auth/kubernetes/login role=demo jwt=$JWT
```
Output of login
```
Key                                   	Value
---                                   	-----
token                                 	6db03f99-09ea-089a-1594-a0b7b10cdb8c
token_accessor                        	c1b3aba4-0a04-8e75-fe58-d94205a20191
token_duration                        	1h0m0s
token_renewable                       	true
token_policies                        	[default demo]
token_meta_role                       	"demo"
token_meta_service_account_name       	"vault-auth"
token_meta_service_account_namespace  	"default"
token_meta_service_account_secret_name	"vault-auth-token-kcgk8"
token_meta_service_account_uid        	"e3270495-e120-11e7-97f9-42010a8001e4"
```
Authenticate to Vault using Token from output for vault write
```
vault auth
```
View the Secret
```
vault read secret/foo
```
Output of the read command
```
Key             	Value
---             	-----
refresh_interval	768h0m0s
password        	Password1!
user            	foo
```

That's it.  That's the bare minimum setup.  Make it better.
