#! /bin/bash

cd app
MIX_ENV=prod ENABLE_CONSULT_SERVER=true ENABLE_PRODUCER_SERVER=true iex -S mix
