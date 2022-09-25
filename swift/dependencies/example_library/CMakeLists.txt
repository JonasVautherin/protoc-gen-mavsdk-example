cmake_minimum_required(VERSION 3.10.2)

project(external-example-library)
include(ExternalProject)

list(APPEND CMAKE_ARGS
    "-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}"
    "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
    "-DBUILD_FRAMEWORK=ON"
    "-DBUILD_TESTING=OFF"
    )

message(STATUS "Preparing external project \"example-library\" with args:")
foreach(CMAKE_ARG ${CMAKE_ARGS})
    message(STATUS "-- ${CMAKE_ARG}")
endforeach()

ExternalProject_add(
    example_library
    URL ${PROJECT_SOURCE_DIR}/../../../cpp
    PREFIX example_library
    CMAKE_ARGS "${CMAKE_ARGS}"
    )
