#/bin/bash
gcloud config set project cisc5550-demo
gcloud compute instances delete cisc5550-api
gcloud compute firewall-rules delete rule-allow-tcp-5001

gcloud compute instances create cisc5550-api --machine-type n1-standard-1 --image-family debian-9 --image-project debian-cloud --tags http-server --metadata-from-file startup-script=./startup.sh
gcloud compute firewall-rules create rule-allow-tcp-5001 --source-ranges 0.0.0.0/0 --target-tags http-server --allow tcp:5001

export TODO_API_IP=`gcloud compute instances list --filter="name=cisc5550-api" --format="value(EXTERNAL_IP)"`

# next, deploy the app that depens on api
docker build -t zhouji2018/cisc5550todoapp .
# docker login
docker push zhouji2018/cisc5550todoapp

gcloud container clusters create cisc5550-cluster
kubectl run cc5550 --image=zhouji2018/cisc5550todoapp --env="TODO_API_IP=$TODO_API_IP" --port=5000
kubectl expose deployment cc5550 --type="LoadBalancer"

kubectl get service cc5550
