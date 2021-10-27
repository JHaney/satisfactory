# Satisfactory Dedicated Server

Built using cm2network/steamcmd.

### Create 2 dirs in docker
- /docker/satisfactory/game
- /docker/satisfactory/config

### SSH in chown them (assumes docker is on volume1)
- chown 1000:1000 /volume1/docker/satisfactory/game
- chown 1000:1000 /volume1/docker/satisfactory/config

### Create image and set mount dirs
- /home/steam/satisfactory-dedicated
- /home/steam/.config/Epic/FactoryGame
