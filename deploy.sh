docker build -t aperea/multi-client:latest -t aperea/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aperea/multi-server:latest -t aperea/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aperea/multi-worker:latest -t aperea/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aperea/multi-client:latest
docker push aperea/multi-server:latest
docker push aperea/multi-worker:latest

docker push aperea/multi-client:$SHA
docker push aperea/multi-server:$SHA
docker push aperea/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aperea/multi-server:$SHA
kubectl set image deployments/client-deployment client=aperea/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aperea/multi-worker:$SHA
