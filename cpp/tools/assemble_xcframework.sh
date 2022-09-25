#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR=${BUILD_DIR:-"${SCRIPT_DIR}/../build"}
IOS_FRAMEWORK_DIR=${BUILD_DIR}/ios/install/lib
IOS_SIM_FRAMEWORK_DIR=${BUILD_DIR}/ios_simulator/install/lib
MACOS_FRAMEWORK_DIR=${BUILD_DIR}/macos/install/lib

if [ -d ${BUILD_DIR}/example_library.xcframework ]; then
    echo "${BUILD_DIR}/example_library.xcframework already exists! Aborting..."
    exit 1
fi

echo "Fixing Modules in macOS framework"
ln -sf Versions/Current/Modules ${MACOS_FRAMEWORK_DIR}/example_library.framework

echo "Creating xcframework..."
#xcodebuild -create-xcframework -framework ${IOS_FRAMEWORK_DIR}/example_library.framework -framework ${IOS_SIM_FRAMEWORK_DIR}/example_library.framework -framework ${MACOS_FRAMEWORK_DIR}/example_library.framework -output ${BUILD_DIR}/example_library.xcframework
xcodebuild -create-xcframework -framework ${MACOS_FRAMEWORK_DIR}/example_library.framework -output ${BUILD_DIR}/example_library.xcframework

#chmod +x ${BUILD_DIR}/example_library.xcframework/ios-arm64/example_library.framework/example_library
#chmod +x ${BUILD_DIR}/example_library.xcframework/ios-x86_64-simulator/example_library.framework/example_library
chmod +x ${BUILD_DIR}/example_library.xcframework/macos-x86_64/example_library.framework/example_library

cd ${BUILD_DIR}
zip -9 -r example_library.xcframework.zip example_library.xcframework

shasum -a 256 example_library.xcframework.zip | awk '{ print $1 }' > example_library.xcframework.zip.sha256

echo "Success! You will find the xcframework in ${BUILD_DIR}!"
