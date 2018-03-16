#!/bin/bash -e

sleep 5
( while [ 1 ]; do sleep 1; echo "y"; done ) | ${ANDROID_HOME}/tools/android update sdk -u
sleep infinity
