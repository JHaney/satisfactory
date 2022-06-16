#!/bin/bash

if [ ! -d ${STEAMCMDDIR} ]; then
	#Root owns this due to the volume mount process so lets take it back.
	chown -R ${USER}:${USER} ${HOMEDIR}
	
	#Now as the user we can get steamcmd and its things configured
	su ${USER} -c \
                "mkdir -p \"${STEAMCMDDIR}\" \
                && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf - -C \"${STEAMCMDDIR}\" \
                && \"./${STEAMCMDDIR}/steamcmd.sh\" +quit \
                && mkdir -p \"${HOMEDIR}/.steam/sdk32\" \
                && ln -s \"${STEAMCMDDIR}/linux32/steamclient.so\" \"${HOMEDIR}/.steam/sdk32/steamclient.so\" \
                && ln -s \"${STEAMCMDDIR}/linux32/steamcmd\" \"${STEAMCMDDIR}/linux32/steam\" \
                && ln -s \"${STEAMCMDDIR}/steamcmd.sh\" \"${STEAMCMDDIR}/steam.sh\""
	
	#Back to root land we need to symbolic link these so the server will actually work later
	ln -s "${STEAMCMDDIR}/linux32/steamclient.so" "/usr/lib/i386-linux-gnu/steamclient.so"
	ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so"
else
	echo "Looks like we are already installed. Skipping....."
fi

# install/update
su ${USER} -c "${STEAMCMDDIR}/steamcmd.sh +force_install_dir ${STEAMAPPDIR} +login anonymous  +app_update ${STEAMAPPID} -beta ${BRANCH} validate +quit"

# launch, the script figures it's diretory out by itself
su ${USER} -c "exec ${STEAMAPPDIR}/FactoryServer.sh"
