kubeNodes=$1
for kubHost in $(cat ${kubeNodes}) ;
do ssh ${kubHost} 'echo -e "\n\t" ; \
	uname -n ; echo -e "\t" ; \
	SEstatus=$(getenforce) ; \
	if [[ ${SEstatus} != 'Disabled' ]] ; \
	then \
		setenforce 0 ; \
		echo -e "Its Disabled now on ${HOST}\n" ; \
	else \
		echo "SELinux is disabled already on this HOST"; \
	fi' ;\
done
