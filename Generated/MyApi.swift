# Summary of values exposed by protoc-gen-mavsdk

## Overview

Names can be accessed as lowerCamelCase, UpperCamelCase, lower_snake_case, Upper_Snake_Case, UPPERCASE, lowercase, like so:

* lower camel case: myApi
* upper camel case: MyApi
* lower snake case: my_api
* upper snake case: My_Api
* uppercase: MY_API

It can also be combined with jinja2 features, for instance:

* lowercase: myapi

## Top level

Each proto file is generated separately. For instance, a proto file can represent a class.

The following is accessible from the top level (i.e. in `file.j2`):

* plugin_name = MyApi
* package = meetup.example.api
* class_description = Example API for C++ meetup
* enumerations (see below)
* structures (see below)
* methods (see below)

## Enumerations
### Mode

* values: {
  UNKNOWN,
  IDLE,
  ACTIVE
}

## Structures
### TwoIntegers
* fields: {
  first,
  second
}

## Methods
There are 3 kinds of methods:

* _Call_ is a method that does not return anything (e.g. void)
* _Request_ is a method that does return something (e.g. a string, an integer, a struct)
* _Stream_ is a method that will return something multiple times (typically it can be implemented by a callback).

### ping (Call)
* params: <none>
* method description: Send a 'ping' and receive a 'pong'

### echo (Request)
* params: {
  send_value: The value being sent
}
* returns _EchoValue_: The value being echoed
* method description: Send a value to be echoed back

### add (Request)
* params: {
  two_integers: Integers to be added together
}
* returns _Result_: Sum of the two integers
* method description: Add two numbers and return the result

### mode (Stream)
* params: <none>
* method description: Subscribe to 'mode' updates.

