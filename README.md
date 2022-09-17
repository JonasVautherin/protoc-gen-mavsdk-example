# Example using protoc-gen-mavsdk

This repository tries to illustrate the use of protoc-gen-mavsdk. The idea is that an API can be defined in a proto file, and protoc-gen-mavsdk will 'export' that API into variables that can be used in jinja2 templates.

Because protoc-gen-mavsdk was built for [MAVSDK](https://github.com/mavlink/mavsdk), it may not always be as generic as one may want. But contributions are welcome!

## Generating the code (for all subprojects)

The script [generate_from_protos.bash](generate_from_protos.bash) generates all the code for this repository from the `some_api.proto` definition. It has two dependencies:

* protoc: this is the actual protobuf compiler, for which protoc-gen-mavsdk is a plugin
* protoc-gen-mavsdk: the protoc plugin around which this repository is built

While `protoc` can usually be installed with the system package manager (e.g. `apt install protobuf-compiler`), `protoc-gen-mavsdk` can be installed with `pip install --user -r requirements.txt` or `pip install --user protoc-gen-mavsdk`.

Once the dependencies have been installed, generate the code by running the script:

```
$ ./generate_from_protos.bash
```

## Subprojects

This repo is generating code for the following "subprojects":

* [cpp](cpp): a very simple c++ library that exposes a few functions.
* [py](py): python bindings on top of the c++ library using pybind11.
* [swift](swift): swift bindings on top of obj-c++ bindings on top of c++ xcframework.
* [cheatsheet.md](cheatsheet.md): an even simpler example of a markdown file generated from a jinja [template](cheatsheet.md.j2) and the `some_api.proto` definition.

## Building the cpp subproject

This is a very standard CMake project that can be built with the usual commands (to be run from the cpp directory, obviously), e.g.:

```
$ cmake -DCMAKE_INSTALL_PREFIX=build/install -Bbuild -S.
$ cmake --build build --target install
```

The resulting library will be installed in `build/install`. A test executable will be available in `build/test`.

## Building the py subproject

This is also a cmake project. But because it depends on the cpp project and on pybind11, those must be provided separately (they will be search for using `find_package` in CMake).

To ease the process, I provide a [dependencies](py/dependencies) CMake project that builds and installs the dependencies. The overall build of the py project (including dependencies) goes like this (to be run from the py directory, obviously):

```
cmake -DCMAKE_INSTALL_PREFIX=dependencies/build/install -Bdependencies/build -Sdependencies
cmake --build dependencies/build

cmake -DCMAKE_PREFIX_PATH=$(pwd)/dependencies/build/install -Bbuild -S.
cmake --build build
```

The resulting library will be available in `build/`, with a name looking like this: `example_library_py.cpython-38-x86_64-linux-gnu.so`.

## Using the py library

Typically the `*.so` library generated by the py project would be embedded in a Python module, but that is left as an exercise for the reader. Still, it can be imported and tried as-is:

```
cd py/build && python
>>> from example_library_py import SomeApi
>>> some_api = SomeApi()
>>> some_api.poke()
Got poked
>>> some_api.echo("test")
'test'
```
