#source
#https://docs.wavefront.com/kubernetes.html?utm_source=Website&utm_medium=referral&utm_campaign=integrations-page#troubleshooting


VAR_WAVEFRONT_SERVER="my.wavefront.com"
VAR_WAVEFRONT_TOKEN="123456789"
VAR_CLUSTER_NAME="kubernetes"


mkdir /root/DeployProxy
mkdir /root/DeployProxy/wavefront-collector-dir
cd /root/DeployProxy


#Step 1. Deploy a Wavefront Proxy in Kubernetes
#----------------------------------------------
rm -f /root/DeployProxy/wavefront.yaml
curl -O  https://raw.githubusercontent.com/wavefrontHQ/wavefront-kubernetes/master/wavefront-proxy/wavefront.yaml
sed -i -e 's/YOUR_CLUSTER.wavefront.com/'"$VAR_WAVEFRONT_SERVER"'/g' wavefront.yaml 
sed -i -e 's/value: YOUR_API_TOKEN/value: '"$VAR_WAVEFRONT_TOKEN"'/g' wavefront.yaml 
#kubectl create -f /root/DeployProxy/wavefront.yaml


#Step 2. Deploy the kube-state-metrics Service
#---------------------------------------------
rm -f /root/DeployProxy/kube-state.yaml
curl -O https://raw.githubusercontent.com/wavefrontHQ/wavefront-kubernetes/master/ksm-all-in-one/kube-state.yaml
#kubectl create -f /root/DeployProxy/kube-state.yaml


#Step 3. Deploy Wavefront Collector for Kubernetes
#-------------------------------------------------
cd /root/DeployProxy/wavefront-collector-dir
rm -f 0-collector-namespace.yaml
rm -f 1-collector-cluster-role.yaml
rm -f 2-collector-rbac.yaml
rm -f 3-collector-service-account.yaml
rm -f 4-collector-daemonset.yaml
curl -O https://raw.githubusercontent.com/wavefrontHQ/wavefront-kubernetes-collector/master/deploy/kubernetes/0-collector-namespace.yaml
curl -O https://raw.githubusercontent.com/wavefrontHQ/wavefront-kubernetes-collector/master/deploy/kubernetes/1-collector-cluster-role.yaml
curl -O https://raw.githubusercontent.com/wavefrontHQ/wavefront-kubernetes-collector/master/deploy/kubernetes/2-collector-rbac.yaml
curl -O https://raw.githubusercontent.com/wavefrontHQ/wavefront-kubernetes-collector/master/deploy/kubernetes/3-collector-service-account.yaml
curl -O https://raw.githubusercontent.com/wavefrontHQ/wavefront-kubernetes-collector/master/deploy/kubernetes/4-collector-daemonset.yaml

sed -i -e 's/clusterName=k8s-cluster/clusterName='"$VAR_CLUSTER_NAME"'/g' 4-collector-daemonset.yaml 

#If RBAC is disabled in your Kubernetes cluster, comment out serviceAccountName: wavefront-collector
sed -i -e '/serviceAccountName: wavefront-collector/s/^/#/g' 4-collector-daemonset.yaml

#kubectl create -f /root/DeployProxy/wavefront-collector-dir

