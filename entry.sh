#!/bin/bash

# install/update
${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${STEAMAPPDIR} +app_update ${STEAMAPPID} +quit

# launch, the script figures it's diretory out by itself
exec ${STEAMAPPDIR}/FactoryServer.sh
