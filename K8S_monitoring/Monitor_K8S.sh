
VAR_WAVEFRONT_URL="https://ALEX_CLUSTER.wavefront.com/api/"
VAR-WAVEFRONT_TOKEN="alextoken"



#Step 1. Deploy a Wavefront Proxy in Kubernetes
#----------------------------------------------

mkdir /root/DeployProxy
cd /root/DeployProxy
curl -O  https://raw.githubusercontent.com/wavefrontHQ/wavefront-kubernetes/master/wavefront-proxy/wavefront.yaml

sed -i -e 's/YOUR_CLUSTER.wavefront.com/'"$VAR_WAVEFRONT_URL"'/g' wavefront.yaml 
sed -i -e 's/value: YOUR_API_TOKEN/'"$VAR_WAVEFRONT_TOKEN"'/g' wavefront.yaml 



#Step 2. Deploy the kube-state-metrics Service
#---------------------------------------------





#Step 3. Deploy Wavefront Collector for Kubernetes
#-------------------------------------------------
