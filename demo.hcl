path "secret/*" {
  capabilities = ["create"]
}

path "secret/*" {
  capabilities = ["read"]
}

path "auth/token/lookup-self" {
  capabilities = ["read"]
}
