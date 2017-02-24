#!/bin/bash
set -e

if [ "$1" = 'worker' ]; then
	if [ -f /app/requirements.txt ]; then
		pip install --upgrade -r /app/requirements.txt
	fi

    exec rq worker "$@"
fi

exec "$@"
