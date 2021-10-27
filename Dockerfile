FROM docker.io/cm2network/steamcmd:steam

LABEL maintainer="someguy@blah.com"

ENV STEAMAPPID 1690800
ENV STEAMAPP satisfactory
ENV STEAMAPPDIR "/${HOMEDIR}/${STEAMAPP}-dedicated"
ENV SAVEDIR "${HOMEDIR}/.config/Epic/FactoryGame"

# ensure diretories for install and save game
RUN mkdir -p ${SAVEDIR} && mkdir -p ${STEAMAPPDIR}

#I need to be root to do this
USER root
#RUN set -x \
#	&& apt-get update \
#	&& apt-get install -y --no-install-recommends --no-install-suggests \
#		libsdl2-2.0-0:i386=2.0.9+dfsg1-1
RUN apt-get -y update && \
    apt-get -y install lib32gcc1 lib32stdc++6 curl libsdl2-2.0 && \
    apt-get clean && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
		
#back to user land
USER ${USER}

VOLUME ${STEAMAPPDIR}
VOLUME ${SAVEDIR}

WORKDIR ${HOMEDIR}

COPY entry.sh .

CMD ["/bin/bash", "entry.sh"]

EXPOSE 7777/udp 15000/udp 15777/udp
