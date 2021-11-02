############################################################
# The One Factory to rule them all
############################################################
FROM debian:buster-slim

LABEL maintainer="someguy@blah.com"
ARG PUID=1000

ENV USER steam
ENV HOMEDIR "/home/${USER}"
ENV STEAMCMDDIR "${HOMEDIR}/steamcmd"

ENV STEAMAPPID 1690800
ENV STEAMAPP satisfactory
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV SAVEDIR "${HOMEDIR}/.config/Epic/FactoryGame"

#Primary install and configuration of app
RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
#		lib32stdc++6=8.3.0-6 \
#		lib32gcc1=1:8.3.0-6 \
#		wget=1.20.1-1.1 \
#		ca-certificates=20200601~deb10u2 \
#		nano=3.2-3 \
		lib32stdc++6 \
		lib32gcc1 \
		wget \
		ca-certificates \
		curl \
		libsdl2-2.0 \
		libsdl2-2.0:i386 \
	&& useradd -u "${PUID}" -m "${USER}" \
	&& su "${USER}" -c \
                "mkdir -p \"${STEAMCMDDIR}\" \
                && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf - -C \"${STEAMCMDDIR}\" \
                && \"./${STEAMCMDDIR}/steamcmd.sh\" +quit \
                && mkdir -p \"${HOMEDIR}/.steam/sdk32\" \
                && ln -s \"${STEAMCMDDIR}/linux32/steamclient.so\" \"${HOMEDIR}/.steam/sdk32/steamclient.so\" \
                && ln -s \"${STEAMCMDDIR}/linux32/steamcmd\" \"${STEAMCMDDIR}/linux32/steam\" \
                && ln -s \"${STEAMCMDDIR}/steamcmd.sh\" \"${STEAMCMDDIR}/steam.sh\"" \
	&& ln -s "${STEAMCMDDIR}/linux32/steamclient.so" "/usr/lib/i386-linux-gnu/steamclient.so" \
	&& ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so" \
	&& apt-get remove --purge -y \
		wget \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

# Switch to user
USER ${USER}

# ensure diretories for install and save game
RUN mkdir -p ${SAVEDIR} && mkdir -p ${STEAMAPPDIR}

#if you dont mount these they will not be persistent and will die when the container stops
VOLUME ${STEAMCMDDIR} 	# optional "/home/steam/steamcmd"
VOLUME ${STEAMAPPDIR} 	# "/home/steam/satisfactory-dedicated"
VOLUME ${SAVEDIR}	# "/home/steam/.config/Epic/FactoryGame"

WORKDIR ${STEAMCMDDIR} #added
WORKDIR ${HOMEDIR}

COPY entry.sh .

CMD ["/bin/bash", "entry.sh"]

EXPOSE 7777/udp 15000/udp 15777/udp
