[![CircleCI](https://dl.circleci.com/status-badge/img/gh/vonmutinda/MLOps/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/vonmutinda/MLOps/tree/main)

## Project Overview

In this project, you will apply the skills you have acquired in this course to operationalize a Machine Learning Microservice API. 

You are given a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. You can read more about the data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). This project tests your ability to operationalize a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

### Project Tasks

Your project goal is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project you will:
* Test your project code using linting
* Complete a Dockerfile to containerize this application
* Deploy your containerized application using Docker and make a prediction
* Improve the log statements in the source code for this application
* Configure Kubernetes and create a Kubernetes cluster
* Deploy a container using Kubernetes and make a prediction
* Upload a complete Github repo with CircleCI to indicate that your code has been tested

You can find a detailed [project rubric, here](https://review.udacity.com/#!/rubrics/2576/view).

**The final implementation of the project will showcase your abilities to operationalize production microservices.**

---
### Running `app.py`

1. Clone the repo
```shell
 $ git clone https://github.com/vonmutinda/MLOps.git
```

2. Install Deps
```shell
$ make setup
$ make install
```
> NB: you may have to run the individual commands for setting up .venv

```shell
$ python3.7 -m venv .venv
$ source ./.venv/bin/activate
$ make install
```

3. Run `appy.py`
> Serve the application on `port 5050` instead of `port 80` by modifying port on `app.py L78`
```shell
$ python app.py
```

*output:*
```shell
[2022-08-14 18:29:48,806] INFO in app: JSON payload: 
{'CHAS': {'0': 0}, 'RM': {'0': 6.575}, 'TAX': {'0': 296.0}, 'PTRATIO': {'0': 15.3}, 'B': {'0': 396.9}, 'LSTAT': {'0': 4.98}}
[2022-08-14 18:29:49,235] INFO in app: Inference payload DataFrame: 
   CHAS     RM    TAX  PTRATIO      B  LSTAT
0     0  6.575  296.0     15.3  396.9   4.98
[2022-08-14 18:29:49,240] INFO in app: Scaling Payload: 
   CHAS     RM    TAX  PTRATIO      B  LSTAT
0     0  6.575  296.0     15.3  396.9   4.98
[2022-08-14 18:29:49,302] INFO in app: 

Ouput Prediction: [20.35373177134412]

127.0.0.1 - - [14/Aug/2022 18:29:49] "POST /predict HTTP/1.1" 200 -
```


4. Make a predicition
```shell
$ ./make_prediction.sh
```
*output:*
```shell
(.venv) ➜  MLOps git:(main) ✗ ./make_prediction.sh 
 Port: 5050
 {
  "prediction": [
    20.35373177134412
  ]
 }
```

### Running App Docker
* Ensure Docker Desktop is running
   ```shell
   $ docker version
   ```

*output:*
```shell
$ MLOps git:(main) ✗ docker version
Client:
 Cloud integration: v1.0.28
 Version:           20.10.17
 API version:       1.41
 Go version:        go1.17.11
 Git commit:        100c701
 Built:             Mon Jun  6 23:04:45 2022
 OS/Arch:           darwin/arm64
 Context:           default
 Experimental:      true

Server: Docker Desktop 4.11.1 (84025)
 Engine:
  Version:          20.10.17
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.17.11
  Git commit:       a89b842
  Built:            Mon Jun  6 23:01:01 2022
  OS/Arch:          linux/arm64
  Experimental:     false
 containerd:
  Version:          1.6.6
  GitCommit:        10c12954828e7c7c9b6e0ea9b0c02b01407d3ae1
 runc:
  Version:          1.1.2
  GitCommit:        v1.1.2-0-ga916309
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

* Run in Docker
   ```shell
   $ ./run_docker.sh
   ```
### Running App in Kubernetes
* Ensure Kubernetes is running
   ```shell
   $ kubectl version --output=json
   ```
*output:*
```shell
{
  "clientVersion": {
    "major": "1",
    "minor": "24",
    "gitVersion": "v1.24.2",
    "gitCommit": "f66044f4361b9f1f96f0053dd46cb7dce5e990a8",
    "gitTreeState": "clean",
    "buildDate": "2022-06-15T14:22:29Z",
    "goVersion": "go1.18.3",
    "compiler": "gc",
    "platform": "darwin/arm64"
  },
  "kustomizeVersion": "v4.5.4",
  "serverVersion": {
    "major": "1",
    "minor": "24",
    "gitVersion": "v1.24.0",
    "gitCommit": "4ce5a8954017644c5420bae81d72b09b735c21f0",
    "gitTreeState": "clean",
    "buildDate": "2022-05-03T13:38:19Z",
    "goVersion": "go1.18.1",
    "compiler": "gc",
    "platform": "linux/arm64"
  }
}
``` 

* Run via kubectl

   ```shell
   $ ./run_kubernetes.sh
   ```

### Useful Guide
- Makefile is rigged with handful commands to get you started in no time.
- If it takes too long to build an image, try the following deps in your `requirements.txt` file instead to see if the image build without errors.
   ```shell
   Click==7.0
   Flask==1.0.2
   itsdangerous==1.1.0
   Jinja2==2.10.3
   MarkupSafe==1.1.1
   numpy==1.17.2
   pandas==0.24.2
   python-dateutil==2.8.0
   pytz==2019.3
   scikit-learn==0.20.3
   scipy==1.3.1
   six==1.12.0
   Werkzeug==0.16.0
   pylint==2.4.4
   black
   ```
