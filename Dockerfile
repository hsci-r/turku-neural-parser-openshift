### GRAB THE MODELS WE WANT, based on build-arg
### I don't know how to tag the base-env using $hardware, so this needs to be built using a script

ARG hardware=cpu

FROM turkunlp/turku-neural-parser:latest-base-${hardware}
ARG models="fi_tdt en_ewt sv_talbanken"
SHELL ["/bin/bash", "-c"]
WORKDIR /app
RUN apt-get install python3-tk; echo "MODELS: $models" && for m in ${models} ; do echo "DOWNLOADING $m" ; python3 fetch_models.py $m ; done && find /app -name "models_*" -type d -exec chmod a+rwx -R {} \;
ENTRYPOINT ["/bin/sh", "-c", "cd /app;./docker_entry_point.sh $0 $@"]
