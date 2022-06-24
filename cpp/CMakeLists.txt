cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_STANDARD 17)
option(BUILD_TESTING "Build tests" ON)

project(example-library)

add_compile_options(-Wall -Wextra -Werror)

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

add_library(example_library
    some_api.cpp
    )

target_link_libraries(example_library
    PRIVATE
    Threads::Threads
    )

if(BUILD_TESTING)
    add_subdirectory(test)
endif()

