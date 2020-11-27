#!/bin/bash

bin="/app/bin/my_app"

eval "$bin eval \"Tweeter.Release.migrate\""
exec "$bin" "start"