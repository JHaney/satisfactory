#!/bin/bash

chown -R ${USER}:${USER} \
        ${STEAMAPPDIR} \
        ${SAVEDIR}

# install/update
su ${USER} -c "${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${STEAMAPPDIR} +app_update ${STEAMAPPID} +quit"

# launch, the script figures it's diretory out by itself
su ${USER} -c "exec ${STEAMAPPDIR}/FactoryServer.sh"
