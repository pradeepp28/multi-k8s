docker build -t pradeepp28/multi-client:latest -t pradeepp28/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pradeepp28/multi-server:latest -t pradeepp28/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pradeepp28/multi-worker:latest -t pradeepp28/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pradeepp28/multi-client:latest
docker push pradeepp28/multi-server:latest
docker push pradeepp28/multi-worker:latest

docker push pradeepp28/multi-client:$SHA
docker push pradeepp28/multi-server:$SHA
docker push pradeepp28/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pradeepp28/multi-server:$SHA
kubectl set image deployments/client-deployment client=pradeepp28/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pradeepp28/multi-worker:$SHA
