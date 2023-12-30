#!/bin/bash

echo "ChatGPT-Next-Web GitHub Project Link: https://github.com/ChatGPTNextWeb/ChatGPT-Next-Web"
# Get current time
current_time=$(date +"%Y-%m-%d %H:%M:%S")

# Stop and delete old containers
old_container_id=$(docker ps -aqf "ancestor=yidadaa/chatgpt-next-web")


if [ -n "$old_container_id" ]; then
    docker stop "$old_container_id"
    docker rm "$old_container_id"
    echo "The old container was stopped and deleted: $old_container_id"
fi


# Pull image updates
echo "Check for image updates..."
docker pull yidadaa/chatgpt-next-web > pull_result.txt
if grep -q "Image is up to date" pull_result.txt; then
    echo "Currently the latest version."
else
    echo "Downloaded the latest version."
fi

# Start a new Docker container and get the container id
container_id=$(docker run -d -p 3000:3000 \
    -e OPENAI_API_KEY="YOU OPEN_API_KEY" \
    -e CODE="YOU CODE" \
    yidadaa/chatgpt-next-web)

{
  echo "Start Time: $current_time";
  echo "Container ID: $container_id";
  echo "----------------------";
} >> container_info.txt

# 输出结果
echo "The new container has been started and details have been written to the container_info.txt file."