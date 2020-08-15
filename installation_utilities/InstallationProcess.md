### Please follow the below steps to install Kubernetes **On-Premise-Machine**
------------------------------------------------------------------------------

- 1: Set differentiable hostnames to all nodes utilised in the Cluster.

		hostnamectl set-hostname "M192168056101.k8x77-mgr-prd.PyDevRa.zone"
	
- 2: Add the hostnames of all the clusternodes in */etc/hosts* file.

        vim /etc/hosts
        192.168.56.101 M192168056101 M192168056101.k8x77-mgr-prd.PyDevRa.zone
        192.168.56.102 M192168056102 M192168056102.k8x77-mgr-prd.PyDevRa.zone
        192.168.56.103 W192168056103 W192168056103.k8x77-wkr-prd.PyDevRa.zone
        192.168.56.104 W192168056104 W192168056104.k8x77-wkr-prd.PyDevRa.zone
        192.168.56.105 W192168056105 W192168056105.k8x77-wkr-prd.PyDevRa.zone


- 3: Disable SELinux in the hosts which will be utilized as Masters/Workers.

		source sesstat.sh

- 4: Add the required Firewall ports to the nodes. Commandline variable can only be the below values for respecter parameters.
	
		source fWstat.s $ROLE $SWITCHER

- 5: Installed 'kubernetes' supported packages.

		source installKube.sh $ROLE

Note:

1. Save the details of all the hostnames seperated by their role 'manager' or 'worker' in two seperate files as named below, which would be used in upcoming steps.
        
		K8sManager.ini
		K8sWorkers.ini
        
2. Commandline variable can only be the below values for respecter parameters.
    
		ROLE: [manager,worker]
		SWITCHER: [0,1]
