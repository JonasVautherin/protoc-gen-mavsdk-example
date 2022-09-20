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

echo "About to use $(which protoc-gen-mavsdk)"...

# Cheatsheet
protoc some_api.proto --plugin=protoc-gen-custom=$(which protoc-gen-mavsdk) -I. --custom_out=. --custom_opt=output_file=cheatsheet.md --custom_opt=template_file=cheatsheet.md.j2 --custom_opt=lstrip_blocks=True --custom_opt=trim_blocks=True

# Cpp
protoc some_api.proto --plugin=protoc-gen-custom=$(which protoc-gen-mavsdk) -I. --custom_out=. --custom_opt=output_file=cpp/src/some_api.h --custom_opt=template_file=cpp/src/some_api.h.j2 --custom_opt=lstrip_blocks=True --custom_opt=trim_blocks=True

# Python
protoc some_api.proto --plugin=protoc-gen-custom=$(which protoc-gen-mavsdk) -I. --custom_out=. --custom_opt=output_file=py/src/some_api_ext.cpp --custom_opt=template_file=py/src/some_api_ext.cpp.j2 --custom_opt=lstrip_blocks=True --custom_opt=trim_blocks=True

# ObjC++
protoc some_api.proto --plugin=protoc-gen-custom=$(which protoc-gen-mavsdk) -I. --custom_out=. --custom_opt=output_file=swift/ExampleLibrary/Sources/ExampleLibraryObjC/include/SomeApiObjC.h --custom_opt=template_file=include/SomeApiObjC.h.j2 --custom_opt=template_path=swift/ExampleLibrary/Sources/ExampleLibraryObjC --custom_opt=lstrip_blocks=True --custom_opt=trim_blocks=True
protoc some_api.proto --plugin=protoc-gen-custom=$(which protoc-gen-mavsdk) -I. --custom_out=. --custom_opt=output_file=swift/ExampleLibrary/Sources/ExampleLibraryObjC/SomeApiObjC.mm --custom_opt=template_file=SomeApiObjC.mm.j2 --custom_opt=template_path=swift/ExampleLibrary/Sources/ExampleLibraryObjC --custom_opt=lstrip_blocks=True --custom_opt=trim_blocks=True

# Swift
protoc some_api.proto --plugin=protoc-gen-custom=$(which protoc-gen-mavsdk) -I. --custom_out=. --custom_opt=output_file=swift/ExampleLibrary/Sources/ExampleLibrary/SomeApi.swift --custom_opt=template_file=SomeApi.swift.j2 --custom_opt=template_path=swift/ExampleLibrary/Sources/ExampleLibrary --custom_opt=lstrip_blocks=True --custom_opt=trim_blocks=True
