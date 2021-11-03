# Satisfactory Dedicated Server

Built using debian:buster-slim

### IF SYNOLOGY
#### Create a dir for the docker volume persistent space IE:
- /docker/satisfactory

#### Launch the image and hit Advanced Settings
#### Select Volume tab and Add the folder you created and set the mount path to:
- /home/steam

#### Set ports from AUTO to their right hand numeric neighboor.
- Auto->15000
- Auto->15777
- Auto->7777

#### Hit Apply then Next->Done and load up satisfactory and finalize your server.