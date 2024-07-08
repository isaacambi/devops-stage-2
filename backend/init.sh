#!/bin/bash

# Path to a file that indicates the initialization has already run
INIT_FLAG="/app/.initialized"

if [ ! -f "$INIT_FLAG" ]; then
  echo "Running prestart script for the first time..."
  poetry run bash ./prestart.sh
  # Mark initialization as done
  touch "$INIT_FLAG"
else
  echo "Prestart script has already run."
fi

# Start the main application
exec "$@"

