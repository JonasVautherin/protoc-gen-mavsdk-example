# Example using protoc-gen-mavsdk

## Generating the code (for all subprojects)

The script [generate_from_protos.bash](generate_from_protos.bash) generates all the code for this repository from the `some_api.proto` definition. It has two dependencies listed in [requirements.txt](requirements.txt):

* protoc-gen-mavsdk: the protoc plugin around which this repository is built
* grpcio-tools: a convenient way to get the `protoc` executable in the PATH. You may be fine with `protoc` installed on your system, though.

The dependencies can be installed with `pip install --user -r requirements.txt`.

Once the dependencies have been installed, generate the code by running the script:

```
$ ./generate_from_protos.bash
```
