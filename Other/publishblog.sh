#!/bin/bash

# Publish blog
# TODO: Add custom dir

manual="Usage: publishblog [Options]\n\n
        [Options]:\n
        -h  Target server\'s host address.\n
        -p  Target server\'s port."

hexo clean && hexo generate

if [ $? -eq 0 ]; then
    scp -P 28000 -r public/* root@192.168.1.77:/var/www/sharryxu/blog
fi

exit 0
