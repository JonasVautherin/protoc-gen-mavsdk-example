[![Build](https://github.com/JonasVautherin/protoc-gen-mavsdk-example/actions/workflows/main.yml/badge.svg)](https://github.com/JonasVautherin/protoc-gen-mavsdk-example/actions/workflows/main.yml)

# Example using protoc-gen-mavsdk

This repository tries to illustrate the use of protoc-gen-mavsdk. The
idea is that an API can be defined in a proto file, and protoc-gen-mavsdk
will "export" that API into variables that can be used in jinja2 templates.

Because protoc-gen-mavsdk was built for
[MAVSDK](https://github.com/mavlink/mavsdk), it may not always be as
generic as one may want. But contributions are welcome!

## Generating the code (for all subprojects)

The script [generate_from_protos.bash](generate_from_protos.bash)
generates all the code for this repository from the `some_api.proto`
definition. It has two dependencies:

* protoc: this is the actual protobuf compiler, for which protoc-gen-mavsdk
is a plugin
* protoc-gen-mavsdk: the protoc plugin around which this repository
is built

While `protoc` can usually be installed with the system package manager
(e.g. `apt install protobuf-compiler`), `protoc-gen-mavsdk` can be
installed with `pip install --user -r requirements.txt` or
`pip install --user protoc-gen-mavsdk`.

Once those dependencies have been installed, generate the code by running
the script:

```
$ ./generate_from_protos.bash
```

## Subprojects

This repo is generating code for the following "subprojects":

* [cpp](cpp): a very simple c++ library that exposes a few functions.
* [py](py): python bindings on top of the c++ library using pybind11.
* [swift](swift): swift bindings on top of obj-c++ bindings on top of
c++ xcframework.
* [cheatsheet.md](cheatsheet.md): an even simpler example of a markdown
file generated from a jinja [template](cheatsheet.md.j2) and the
`some_api.proto` definition.

