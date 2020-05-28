#!/bin/bash
set -e

echo "Installing gcloud sdk"
curl https://sdk.cloud.google.com | bash

source ~/.zshrc
gcloud init
