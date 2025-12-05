#!/bin/sh
set -e

if [ "${1#-}" != "$1" ] || ! command -v "$1" >/dev/null 2>&1; then
    set -- curl "$@"
fi

exec "$@"
