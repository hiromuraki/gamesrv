#!/bin/bash

./hlds_run -game cstrike \
    -insecure \
    -nomaster \
    -strictportbind \
    -ip 0.0.0.0 \
    -port 27015 \
    +exec "gamemode_deathmatch.cfg" \
    +map de_dust2
