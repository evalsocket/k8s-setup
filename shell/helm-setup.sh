
#!/bin/bash
PATH=/usr/sbin:/sbin:/usr/bin:/bin

#Download and install the helm binary
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.14.1-linux-amd64.tar.gz

#Unzip the file to your local system:
tar zxfv helm-v2.14.1-linux-amd64.tar.gz
cp linux-amd64/helm .

#Add yourself as a cluster administrator in the cluster's RBAC so that you can give Jenkins permissions in the cluster:
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value account)

#Grant Tiller, the server side of Helm, the cluster-admin role in your cluster:
kubectl create serviceaccount tiller --namespace kube-system
kubectl create clusterrolebinding tiller-admin-binding --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

#Initialize Helm. This ensures that the server side of Helm (Tiller) is properly installed in your cluster.
./helm init --service-account=tiller
./helm update

#Ensure Helm is properly installed by running the following command. You should see versions appear for both the server and the client of v2.14.1:
./helm version

# Install wave  cloud
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# Install flux
kubectl apply -f https://raw.githubusercontent.com/fluxcd/flux/helm-0.10.1/deploy-helm/flux-helm-release-crd.yaml
./helm repo add fluxcd https://charts.fluxcd.io


