docker build -t rhpvieira/multi-client:latest -t rhpvieira/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t rhpvieira/multi-server:latest -t rhpvieira/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t rhpvieira/multi-worker:latest -t rhpvieira/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push rhpvieira/multi-client:latest
docker push rhpvieira/multi-server:latest
docker push rhpvieira/multi-worker:latest

docker push rhpvieira/multi-client:$GIT_SHA
docker push rhpvieira/multi-server:$GIT_SHA
docker push rhpvieira/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=rhpvieira/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=rhpvieira/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=rhpvieira/multi-worker:$GIT_SHA
