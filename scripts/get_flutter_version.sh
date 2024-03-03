#!/bin/bash

# JSON file path
JSON_FILE=".fvm/fvm_config.json"



# check if file exists
if [ ! -f "$JSON_FILE" ]; then
  exit 1
fi

# get flutterSdkVersion
FLUTTER_SDK_VERSION=$(grep -o '"flutterSdkVersion": *"[^"]*"' "$JSON_FILE" | awk -F '"' '{print $4}')

# check if flutterSdkVersion is empty
if [ -z "$FLUTTER_SDK_VERSION" ]; then
  exit 1
fi

echo $FLUTTER_SDK_VERSION