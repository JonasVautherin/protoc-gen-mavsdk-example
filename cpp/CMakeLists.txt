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

set_target_properties(example_library PROPERTIES PUBLIC_HEADER some_api.h)

include(GNUInstallDirs)

install(TARGETS example_library
    EXPORT ExampleLibraryTargets
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/example_library
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    )

install(EXPORT ExampleLibraryTargets
    FILE ExampleLibraryTargets.cmake
    NAMESPACE ExampleLibrary::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/ExampleLibrary
    )

# For the build tree
configure_file(ExampleLibraryConfig.cmake.in
    "${PROJECT_BINARY_DIR}/ExampleLibraryConfig.cmake" @ONLY)
# For the install tree
configure_file(ExampleLibraryConfig.cmake.in
    "${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/ExampleLibraryConfig.cmake" @ONLY)

install(FILES
    "${PROJECT_BINARY_DIR}/${CMAKE_FILES_DIRECTORY}/ExampleLibraryConfig.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/ExampleLibrary)

if(BUILD_TESTING)
    add_subdirectory(test)
endif()

