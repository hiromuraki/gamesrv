#!/bin/bash

./hlds_run -game cstrike \
    -insecure \
    -nomaster \
    -strictportbind \
    -ipv4 \
    -ip 0.0.0.0 \
    -port 27015 \
    +maxplayers 16 \
    +map de_dust2
