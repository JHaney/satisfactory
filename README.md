# Satisfactory Dedicated Server

Built using debian:buster-slim

### Create 2 dirs in docker
- /docker/satisfactory/game
- /docker/satisfactory/config

### SSH in chown them (assumes docker is on volume1)
- sudo chown 1000:1000 /volume1/docker/satisfactory/game
- sudo chown 1000:1000 /volume1/docker/satisfactory/config

### Create image and set mount dirs
- /home/steam/satisfactory-dedicated
- /home/steam/.config/Epic/FactoryGame
