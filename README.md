# About Carbon Footprint Counter
Calculate carbon footprint into enterprises

## Installation using ZPM
1. Execute this command from IRIS Terminal:
```
zpm "install carbon-footprint-counter"
```
2. Access the Carbon Footprint Counter UI: http://localhost:52775/carboncounter/index.html

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

4. Go to http://localhost:52775/carboncounter/index.html to use the Carbon Counter frontend

![Main screen](https://github.com/yurimarx/carbon-footprint-counter/raw/main/mobile.png "Main Screen")

# Online demo
See online and try it: ymservices.tech:52775/carboncounter/index.html

# Related articles
Article about the app: https://community.intersystems.com/post/measure-greenhouse-gas-ghg-emissions-carbon-footprint-counter-app

# Related Video
YouTube Video: https://youtu.be/jfSm6-0TkIs

# Credits
I used the database and the rules from Green House Gas Protocol: https://ghgprotocol.org/ghg-emissions-calculation-tool