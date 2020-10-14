```
$ htpasswd -c auth dokify
New password: <bar>
New password:
Re-type new password:
Adding password for user foo
$ kubectl create secret generic basic-auth-jenkins-dokify --from-file=auth
secret "basic-auth-jenkins-dokify" created
$ kubectl get secret basic-auth-jenkins-dokify -o yaml
```

```yaml
apiVersion: v1
data:
  auth: Zm9vOiRhcHIxJE9GRzNYeWJwJGNrTDBGSERBa29YWUlsSDkuY3lzVDAK
kind: Secret
metadata:
  name: basic-auth
  namespace: default
type: Opaque
```
