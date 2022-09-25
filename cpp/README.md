# Build

This is a very standard CMake project that can be built with the usual
commands (to be run from the cpp directory, obviously), e.g.:

```
$ cmake -DCMAKE_INSTALL_PREFIX=build/install -Bbuild -S.
$ cmake --build build --target install
```

The resulting library will be installed in `build/install`. A test
executable will be available in `build/test`.

# Autogeneration

The header file `some_api.h` is generated from the template
`some_api.h.j2`, while the implementation has to be written manually.

The point is that the autogeneration handles the API, so that other layers
can call it (e.g. the python/swift wrappers).

In order to run the autogen, call the following script:

```
$ ../generate_from_protos.bash
```

This only needs to be called when the proto files or templates are changed.

