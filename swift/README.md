# Build

First, you need to build the cpp library that this project will be wrapping
with its Swift API. I provide a helper script in
[dependencies](dependencies/) to enable that:

```
cmake -DCMAKE_INSTALL_PREFIX=build/macos/install -Bbuild/macos -Sdependencies
cmake --build build/macos
```

This will result in an `example_library.framework` in
`./macos/install/lib`. But in order to be used by SwiftPM, it has to be
an xcframework. The following script makes an xcframework out of it:

```
BUILD_DIR=$(pwd)/build bash ../cpp/tools/assemble_xcframework.sh
```

It will result in `example_library.xcframework` in `./build`. This is the
xcframework that will be picked up by SwiftPM from
[Package.swift](ExampleLibrary/Package.swift).

You are now ready to build the swift package. From
[ExampleLibrary/](ExampleLibrary/), run:

```
swift build
```

# Autogeneration

In order to run the autogen, call the following script:

```
$ ../generate_from_protos.bash
```

This only needs to be called when the proto files or templates are changed.

