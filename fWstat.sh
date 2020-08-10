ROLE=$1
SWITCHER=$2

if [[ ${ROLE} == 'manager' ]]
then
nodeType=K8sManager
elif [[ ${ROLE} == 'worker' ]]
then
nodeType=K8sWorkers
else
	exit 121 "Enter a proper value"
fi

if [[ ${SWITCHER} -eq 1 ]]
then
TxN="add"
StATE="start"
InIt="enable"
elif [[ ${SWITCHER} -eq 0 ]]
then
TxN="remove"
StATE="stop"
InIt="disable"
else
	exit 131 "Please give me a switcher"
fi

#for kubHost in $(docker node ls --filter role=${ROLE} --format "{{json ."Hostname"}}" | tr -d '"' )
for kubHost in $(cat ${nodeType}); do ssh ${kubHost} 
	        "$(echo $(echo -n "\nUSER:\t${USER}\nHOST:\t$(uname -n)\nDATE:\t$(date)\nDOCKER:\t$(systemctl is-active docker)\nNodeType:${ROLE}") ; \
                sleep 1 ;  systemctl status firewalld ; systemctl ${StATE} firewalld && systemctl ${InIt} firewalld ; \
		echo -e "FirewallD is ${StATE}ed now on ${HOST}\n ${TxN}ing required ports and services" ; \
		firewall-cmd --permanent --${TxN}-port={2376-2380/udp,10250-10252/udp,10255/udp,6443/udp,7946/udp,4789/udp} ; \
		firewall-cmd --permanent  --${TxN}-port={2376-2380/tcp,10250-10252/tcp,10255/tcp,6443/tcp,7946/tcp,4789/tcp} ; \
		firewall-cmd --permanent --${TxN}-service={http,https,nfs,rpc-bind}; \
	       	firewall-cmd --complete-reload && firewall-cmd --list-ports  ; firewall-cmd --list-services ; \
		echo -e "Enabling br_netfilter module\n" ; modprobe br_netfilter ; \
		echo "1" > /proc/sys/net/bridge/bridge-nf-call-iptables)";
done
