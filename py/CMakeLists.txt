cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_STANDARD 17)

project(example-library-py)

add_compile_options(-Wall -Wextra -Werror)

find_package(ExampleLibrary REQUIRED)
find_package(pybind11 REQUIRED)

pybind11_add_module(example_library_py
    src/some_api_ext.cpp
    )

target_link_libraries(example_library_py
    PRIVATE
    ExampleLibrary::example_library
    pybind11::module
    )

#include(GNUInstallDirs)
#
#install(TARGETS example_library
#    EXPORT example-library-targets
#    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/some_api
#    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
#    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
#    )

