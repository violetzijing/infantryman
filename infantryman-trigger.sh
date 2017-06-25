#!/bin/bash

if [ -x "$(command -v websocketd)" ]; then
  echo "Websocketd has't been installed"
fi

websocketd --port=12333 ./infantryman.rb
