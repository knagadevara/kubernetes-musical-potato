
ROLE=$1

if [[ ${ROLE} == 'manager' ]]
then
nodeType=K8sManager
elif [[ ${ROLE} == 'worker' ]]
then
nodeType=K8sWorkers
else
        exit 121 "Enter a proper value"
fi


#for kubHost in $(docker node ls --filter role=manager --format "{{json ."Hostname"}}" | tr -d '"' ) 

for kubHost in $(cat ${nodeType});	
do 
	ssh ${kubHost}  \ 
	'echo -e "\n\t" ; uname -n ; \ 
	cp "kube.repo" "/etc/yum.repos.d/kubernetes.repo" ; \
	ls -alstr "/etc/yum.repos.d/" ; yum repolist all ; \
        dnf install -y kubeadm kubectl --disableexcludes=kubernetes' ;
done
