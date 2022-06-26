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

protoc some_api.proto --plugin=protoc-gen-custom=$(which protoc-gen-mavsdk) -I. --custom_out=. --custom_opt=output_file=example.md --custom_opt=template_file=example.md.j2 --custom_opt=lstrip_blocks=True --custom_opt=trim_blocks=True

protoc some_api.proto --plugin=protoc-gen-custom=$(which protoc-gen-mavsdk) -I. --custom_out=. --custom_opt=output_file=cpp/some_api.h --custom_opt=template_file=cpp/some_api.h.j2 --custom_opt=lstrip_blocks=True --custom_opt=trim_blocks=True

protoc some_api.proto --plugin=protoc-gen-custom=$(which protoc-gen-mavsdk) -I. --custom_out=. --custom_opt=output_file=py/some_api_ext.cpp --custom_opt=template_file=py/some_api_ext.cpp.j2 --custom_opt=lstrip_blocks=True --custom_opt=trim_blocks=True
