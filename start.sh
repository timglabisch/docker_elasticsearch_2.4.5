#!/bin/bash

chmod -R 777 /elasticsearch-2.4.5/data
chown -R elasticsearch:elasticsearch "/elasticsearch-2.4.5"

if [ "$*" == "" ]; then
    sudo -u elasticsearch /elasticsearch-2.4.5/bin/elasticsearch
else
    /bin/bash -l -c "$*"
fi