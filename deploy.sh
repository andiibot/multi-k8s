docker build -t andiibot/multi-client:latest -t andiibot/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andiibot/multi-server:latest -t andiibot/multi-server:$SHA -f ./server/Dockerfile ./client
docker build -t andiibot/multi-worker:latest -t andiibot/multi-worker:$SHA -f ./worker/Dockerfile ./client

docker push andiibot/multi-client:latest
docker push andiibot/multi-server:latest
docker push andiibot/multi-worker:latest

docker push andiibot/multi-client:$SHA
docker push andiibot/multi-server:$SHA
docker push andiibot/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=andiibot/multi-client:$SHA
kubectl set image deployments/server-deployment server=andiibot/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=andiibot/multi-worker:$SHA