#!/bin/bash
pth=$1
if [ -z "$pth" ]; then
    echo Specify path to build
    exit 1
fi
if [[ -n $(git status --short) ]]; then
    git status
    echo Clean git status and commit before building image.
    exit 2
fi

name=$(basename $(realpath $pth))
tag=$(git rev-parse --short HEAD)
hub_org=lisacuk
user=lisds
img_name="${name}:${tag}"
full_name="${hub_org}/${img_name}"

echo Building...
docker buildx build --platform linux/amd64 -t ${full_name} ${pth}

echo "To deploy:"
echo
echo "docker login --username=$user"
echo "docker push ${full_name}"
