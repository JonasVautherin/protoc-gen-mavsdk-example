#!/usr/bin/env bash

set -e

command -v protoc || { echo >&2 "Could not find 'protoc'! Protobuf needs to be installed for this script to run!"; exit 1; }

command -v protoc-gen-mavsdk > /dev/null || {
    echo "------------------------"
    echo "Error"
    echo "------------------------"
    echo >&2 "'protoc-gen-mavsdk' not found in PATH"
    echo >&2 ""
    echo >&2 "You can install it using pip:"
    echo >&2 ""
    echo >&2 "pip3 install --user protoc-gen-mavsdk"
    exit 1
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR=${OUTPUT_DIR:-"${SCRIPT_DIR}/Generated"}

if [ ! -d ${OUTPUT_DIR} ]; then
    echo "Script is not in the right location! It is made to generate the files in '${OUTPUT_DIR}', which doesn't exist!"

    exit 1
fi

export TEMPLATE_PATH=${TEMPLATE_PATH:-"${SCRIPT_DIR}"}

protoc my_api.proto --plugin=protoc-gen-custom=$(which protoc-gen-mavsdk) -I. --custom_out=${OUTPUT_DIR} --custom_opt=file_ext=swift
