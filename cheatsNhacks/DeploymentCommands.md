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
        or
        kubectl get rs,svc,deployments --show-labels

- : To switch the present namespace context
    - : To get the current context

                kubectl config current-context

    - : To set the current context to point to desired namespace

                kubectl config set-context $(kubectl config current-context) --namespace="<NameOfNameSpace>"

    - : To verify the details
        
                kubectl config view

- : To know more information on the resources by 'describe'

	syntax: kubectl describe <object-kind>/<object-name>
	
        kubectl describe rs/<replicationSet-name>
        kubectl describe pod/<pod-name>
        kubectl describe deployment/<deployment-name>

**Ideal way to update an object in Production is via applying the configuration in 'yaml' file, through which all the changes can be versioned**
   
 	  	kubectl apply -f <path to file>

- Rolling update paramertes: maxSurge,maxUnavailable defaults to 25% of existing desired state.

    - To check the rollout status

	        kubectl rollout status deployment/<deployment-name>

    - To check the rollout History and the related component which got updated, helps in rolling back.

	        kubectl rollout history deployment/<deployment-name> --revision=<revision-number>

    - To rollback to the previous

	        kubectl rollout undo deployment/<deployment-name> --to-revision=<previous-revision-number>


**Not Recommended in Production**

- : To manually expose the deployment but not recomended in production.

        kubectl expose deployment <deployment-name> --type=NodePort

- : Upgrade and Rollout component in the deployment

    - Upgrade the deployment with new image

	        kubectl set image deployment/<deployment-name> <container-name>=<newimage-name>

    - To edit the existing running configuration which inturn updates the objectt
    
    		kubectl edit deployment/<deployment-name>

- to create a congif map from a file and mount it to a volume

        kubectl create configmap --from-file <pathTofile> <configmapName>
        kubectl describe configmap/<configmapName>

        example as below,
        kubectl create configmap --from-file redisconf-file redis-configmap


    spec:
      containers:
      volumes:
        - name: redisconf
          configMap:
            name: redis-configmap
        

        - name: standalone-redis-app
          image: "redis:6.0-alpine3.12"
          resources:
            limits:
              memory: "128Mi"
              cpu: "250m"
          ports:
          - containerPort: 6379
            protocol: TCP
          volumeMounts:
            - name: redisconf
              subPath: redisconf-file
              mountPath: /etc/redis

        
- To maintain 'Secrets' in a file we are required to generate Base64 encrypted strings ehich then go into the yaml file

        echo "myPassword" | base64
        