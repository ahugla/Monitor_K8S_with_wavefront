
VAR_WAVEFRONT_SERVER="ALEX_CLUSTER.wavefront.com"
VAR_WAVEFRONT_TOKEN="alextoken"


mkdir /root/DeployProxy
cd /root/DeployProxy

#Step 1. Deploy a Wavefront Proxy in Kubernetes
#----------------------------------------------
rm -f /root/DeployProxy/wavefront.yaml
curl -O  https://raw.githubusercontent.com/wavefrontHQ/wavefront-kubernetes/master/wavefront-proxy/wavefront.yaml
sed -i -e 's/YOUR_CLUSTER.wavefront.com/'"$VAR_WAVEFRONT_SERVER"'/g' wavefront.yaml 
sed -i -e 's/value: YOUR_API_TOKEN/value: '"$VAR_WAVEFRONT_TOKEN"'/g' wavefront.yaml 


#Step 2. Deploy the kube-state-metrics Service
#---------------------------------------------

rm -f /root/DeployProxy/kube-state.yaml
curl -O https://raw.githubusercontent.com/wavefrontHQ/wavefront-kubernetes/master/ksm-all-in-one/kube-state.yaml




#Step 3. Deploy Wavefront Collector for Kubernetes
#-------------------------------------------------




#Deploy yaml files
#-----------------
#kubectl create -f /root/DeployProxy/wavefront.yaml
#kubectl create -f /root/DeployProxy/kube-state.yaml
