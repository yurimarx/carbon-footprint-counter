# About Carbon Footprint Counter
Calculate carbon footprint into enterprises

## Installation using ZPM
1. Execute this command from IRIS Terminal:
```
zpm "install carbon-footprint-counter"
```
2. Access Mindmap UI: http://localhost:52775/csp/carbon-counter/index.html

## Installation using Docker Compose
1. Clone/git pull the repo into any local directory

```
$ git clone https://github.com/yurimarx/carbon-footprint-counter.git
```

2. Open a Docker terminal in this directory and run:

```
$ docker-compose build
```

3. Run the IRIS container:

```
$ docker-compose up -d 
```

4. Go to http://localhost:4200 or http://localhost:52775/csp/carbon-counter/index.html to use the Carbon Counter frontend
