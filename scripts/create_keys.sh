#!/usr/bin/sh

sudo mkdir -p keys/web keys/worker

sudo ssh-keygen -t rsa -f ./keys/web/tsa_host_key -N ''
sudo ssh-keygen -t rsa -f ./keys/web/session_signing_key -N ''

sudo ssh-keygen -t rsa -f ./keys/worker/worker_key -N ''

sudo cp ./keys/worker/worker_key.pub ./keys/web/authorized_worker_keys
sudo cp ./keys/web/tsa_host_key.pub ./keys/worker

