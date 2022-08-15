
dockerpath:=vonmutinda/mlops
port:=5050
version:=v1.0.0

# NB: source manually
# Install python3.7 
setup:
	python3.7 -m venv .venv && \
	source ./.venv/bin/activate

install: 
	pip install --upgrade pip 
	pip install -r requirements.txt

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	python3 -m black .
	hadolint Dockerfile
	pylint --disable=R,C,W1202,W1203,W1202,C0114,C0103 app.py

build:
	docker build -t mlops .

# e.g make tag version=v1.0.0
tag:
	docker tag mlops $(dockerpath):$(version)

push:
	docker push vonmutinda/mlops:$(version)

server:
	docker run --name mlops-$(version) -d -p $(port):80 mlops

# e.g make deploy version=v1.0.2
deploy:
	kubectl create deploy mlops --image=$(dockerpath):$(version)

rollback-deployment:
	kubectl delete deployment.apps/mlops

cluster-status:
	kubectl get deploy,rs,svc,pods

port-forward:
	kubectl port-forward deployment.apps/mlops $(port):80

stop:
	docker stop mlops-$(version)
