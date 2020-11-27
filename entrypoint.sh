#!/bin/bash

bin="/app/bin/tweeter"

eval "$bin eval \"Tweeter.Release.migrate\""
exec "$bin" "start"