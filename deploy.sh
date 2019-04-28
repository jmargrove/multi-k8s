docker build -t grovejam/multi-client:latest -t grovejam/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t grovejam/multi-server:latest -t grovejam/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t grovejam/multi-worker:latest -t grovejam/multi-worker:$SHA -f ./worker/Dockerfilr ./worker
docker push grovejam/multi-client:latest
docker push grovejam/multi-client:$SHA
docker push grovejam/multi-server:latest
docker push grovejam/multi-server:$SHA
docker push grovejam/multi-worker:latest
docker push grovejam/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=grovejam/multi-server:$SHA
kubectl set image deployments/client-deployment client=grovejam/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=grovejam/multi-worker:$SHA