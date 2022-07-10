ARG IMAGE=intersystemsdc/iris-community
FROM $IMAGE


USER root

WORKDIR /opt/carbon-counter

RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} .

COPY irissession.sh /
RUN chmod +x /irissession.sh 

USER ${ISC_PACKAGE_MGRUSER}

COPY Installer.cls .

COPY src src
COPY web/dist/sakai csp
COPY emissionfactors.csv emissionfactors.csv

SHELL ["/irissession.sh"]

RUN \
  do $SYSTEM.OBJ.Load("Installer.cls", "ck") \
  set sc = ##class(App.Installer).setup() \
  set ^|"CARBONCOUNTER"|UnitTestRoot = "/opt/carbon-counter/tests"

SHELL ["/bin/sh", "-c"]