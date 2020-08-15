- : To get the list of running k8s resources

        kubectl get pods -l 'environment in (production),tier in (frontend)'
        or
        kubectl get pods -l environment=production,tier=frontend
        or
        kubectl get pods -l 'environment in (production, qa)'
        or
        kubectl get pods --field-selector=status.phase!=Running,spec.restartPolicy=Always
        or
        kubectl get statefulsets,services --all-namespaces --field-selector metadata.namespace!=default
        or
        kubectl get rs
        or
        kubectl get deployments
        or
        kubectl get service

- : To know more information on the resources by 'describe'

        kubectl describe rs/<replicationSet-name>
        kubectl describe pod/<pod-name>
        kubectl describe deployment/<deployment-name>

**Not Recommended in Production**

- : To manually expose the deployment but not recomended in production.

        kubectl expose deployment <deployment-name> --type=NodePort

- : Upgrade and Rollout component in the deployment

    - Upgrade the deployment with new image

	        kubectl set image deployment/<deployment-name> <container-name>=<newimage-name>

    - To check the rollout status

	        kubectl rollout status deployment/<deployment-name>

    - To check the rollout History

	        kubectl rollout history deployment/<deployment-name>

    - To rollback to the previous

	        kubectl rollout undo deployment/<deployment-name>

    - To edit the existing running configuration

		kubectl edit deployment/<deployment-name>
