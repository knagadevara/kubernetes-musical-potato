Selector
--------

         selector:
            matchLabels:
                component: redis
            matchExpressions:
                - {key: tier, operator: In, values: [cache]}
                - {key: environment, operator: NotIn, values: [dev]}


Label
-----

- : The Deployment is used to oversee the pods running the application itself.

        apiVersion: apps/v1
        kind: Deployment
        metadata:
        labels:
            app.kubernetes.io/name: wordpress
            app.kubernetes.io/instance: wordpress-abcxzy
            app.kubernetes.io/version: "4.9.4"
            app.kubernetes.io/managed-by: helm
            app.kubernetes.io/component: server
            app.kubernetes.io/part-of: wordpress
        ...


- : The Service is used to expose the application.

        apiVersion: v1
        kind: Service
        metadata:
        labels:
            app.kubernetes.io/name: wordpress
            app.kubernetes.io/instance: wordpress-abcxzy
            app.kubernetes.io/version: "4.9.4"
            app.kubernetes.io/managed-by: helm
            app.kubernetes.io/component: server
            app.kubernetes.io/part-of: wordpress
        ...

- : MySQL is exposed as a StatefulSet with metadata for both it and the larger application it belongs to:

        apiVersion: apps/v1
        kind: StatefulSet
        metadata:
        labels:
            app.kubernetes.io/name: mysql
            app.kubernetes.io/instance: mysql-abcxzy
            app.kubernetes.io/version: "5.7.21"
            app.kubernetes.io/managed-by: helm
            app.kubernetes.io/component: database
            app.kubernetes.io/part-of: wordpress
        ...

- : The Service is used to expose MySQL as part of WordPress:

        apiVersion: v1
        kind: Service
        metadata:
        labels:
            app.kubernetes.io/name: mysql
            app.kubernetes.io/instance: mysql-abcxzy
            app.kubernetes.io/version: "5.7.21"
            app.kubernetes.io/managed-by: helm
            app.kubernetes.io/component: database
            app.kubernetes.io/part-of: wordpress
        ...

Note:
1. Shared labels and annotations share a common prefix: "app.kubernetes.io" and labels without a prefix are private to users. The shared prefix ensures that shared labels do not interfere with custom user labels.
2. StatefulSet mostly used for databases and with  MySQL 'StatefulSet and Service' you'll notice information about both MySQL and Wordpress, the broader application, are included.
