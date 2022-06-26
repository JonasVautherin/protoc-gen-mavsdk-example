cmake_minimum_required(VERSION 3.10.2)

project(external-pybind11)
include(ExternalProject)

list(APPEND CMAKE_ARGS
    "-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}"
    "-DBUILD_TESTING=OFF"
    )

message(STATUS "Preparing external project \"pybind11\" with args:")
foreach(CMAKE_ARG ${CMAKE_ARGS})
    message(STATUS "-- ${CMAKE_ARG}")
endforeach()

ExternalProject_add(
    pybind11
    URL https://github.com/pybind/pybind11/archive/refs/tags/v2.9.2.tar.gz
    PREFIX pybind11
    CMAKE_ARGS "${CMAKE_ARGS}"
    )
