############################################################
# The One Factory to rule them all
############################################################
FROM debian:buster-slim

ARG PUID=1000

ENV USER steam
ENV HOMEDIR "/home/${USER}"
ENV STEAMCMDDIR "${HOMEDIR}/steamcmd"

ENV STEAMAPPID 1690800
ENV STEAMAPP satisfactory
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV SAVEDIR "${HOMEDIR}/.config/Epic/FactoryGame"

ENV BRANCH "public"

#Primary install and configuration of app
RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		lib32stdc++6 \
		lib32gcc1 \
		wget \
		ca-certificates \
		curl \
		libsdl2-2.0 \
		libsdl2-2.0:i386 \
	&& useradd -u "${PUID}" -m "${USER}" \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

# Mount or Die. 
VOLUME ${HOMEDIR}	#Mount to: /home/steam

COPY entry.sh .

CMD ["/bin/bash", "entry.sh"]

EXPOSE 7777/udp 15000/udp 15777/udp
