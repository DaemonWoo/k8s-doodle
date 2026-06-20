kind create cluster --name hello-cluster --config kind-config.yaml

docker build -t hello-python:v3 app
kind load docker-image hello-python:v3 --name hello-cluster