#!/bin/bash

# flavor name
flavor=$1

# build.gradle path
gradle_file="app/android/app/build.gradle"

# flavor kontrolü
if [ -z "$flavor" ]; then
 
    exit 1
fi

# change directory to android
if [ ! -f "$gradle_file" ]; then

    exit 1
fi

# applicationId değerini almak için grep komutunu kullanma
applicationId=$(awk '/applicationId / {print $2}' "$gradle_file" | tr -d '"')


# set application id suffix
if [ "$flavor" == "staging" ]; then
    APPLICATION_ID_SUFFIX=".stg"
elif [ "$flavor" == "development" ]; then
    APPLICATION_ID_SUFFIX=".dev"
else
    APPLICATION_ID_SUFFIX=""
fi

# echo full application id
echo "$applicationId$APPLICATION_ID_SUFFIX"



