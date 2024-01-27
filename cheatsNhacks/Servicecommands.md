### Pod runs
------------

- Pod
    Createing a new pod with single container from cli.

        kubectl run pod <name> --image=<image_name> --env "KEY1=VAL1" --env "KEY2=VAL2" --env "KEY_N=VAL_N" --labels="k1=v1,k2=v2..,kn=vn" --restart=Alyays --command -- <cmd> <arg1> .. <argn> 

    Applying the a manifest and realizing a pod.

        kubectl run pod <name> --image <image_name> --dry-run=server -o yaml | tee myPod.yaml

        ## make necessary changes to myPod.yaml manifest

        kubectl apply -f myPod.yaml

    Pods generally do not allow to edit(make any changes to spec.*), in such cases it is requirted to replace.

        kubectl replace --force -f myPod.yaml


- ConfigMap
    Create ConfigMap from a file

        kubectl create configmap <cm_name> --from-file=path/to/file --from-file=path/to/file --dry-run=server -o yaml | tee <cm_name>.yaml 
        
        kubectl apply -f <cm_name>.yaml

- Secrets
    Create secret of type 'GENERIC/OPAQUE' from a file

        kubectl create secret generic <sec_name> --from-file=path/to/file --from-file=path/to/file --dry-run=server -o yaml | tee <sec_name>.yaml 
        
        kubectl apply -f <sec_name>.yaml

    Secret for Service Account: When a new SA is created it is now(from k8s v1.24) required to create a secret of type "kubernetes.io/servie-account-token" and which contains the token and mounts it on to it.

        kubectl create serviceaccount <sa-name>

### ClusterIP Service
---------------------

- Inaccessable from outside, will **only allow** pods or containers deployed in the cluster to access the service port which is bound to it.
