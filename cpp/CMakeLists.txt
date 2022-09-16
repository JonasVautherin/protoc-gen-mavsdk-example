cmake_minimum_required(VERSION 3.10)

set(VERSION "1.0.0")

set(CMAKE_CXX_STANDARD 17)
option(BUILD_TESTING "Build tests" ON)
option(BUILD_FRAMEWORK "Build framework (for Apple platforms)" OFF)

project(example-library)

add_compile_options(-Wall -Wextra -Werror)

if(NOT APPLE AND BUILD_FRAMEWORK)
    message(WARNING "-DBUILD_FRAMEWORK is only available on Apple platforms! Ignoring...")
    set(BUILD_FRAMEWORK OFF)
endif()

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

add_library(example_library
    src/some_api.cpp
    src/some_api.h
    module.modulemap
    )

target_link_libraries(example_library
    PRIVATE
    Threads::Threads
    )

set_target_properties(example_library PROPERTIES
    PUBLIC_HEADER src/some_api.h
    SOVERSION ${VERSION}
)

if(BUILD_FRAMEWORK)
    set_property(SOURCE module.modulemap
        PROPERTY MACOSX_PACKAGE_LOCATION "Modules")

    set_target_properties(example_library PROPERTIES
        FRAMEWORK TRUE
        BUILD_WITH_INSTALL_RPATH TRUE
        INSTALL_NAME_DIR @rpath
        MACOSX_FRAMEWORK_INFO_PLIST ${PROJECT_SOURCE_DIR}/cmake/MacOSXFrameworkInfo.plist.in
    )
endif()

include(GNUInstallDirs)

if(BUILD_FRAMEWORK)
    install(TARGETS example_library
        FRAMEWORK DESTINATION ${CMAKE_INSTALL_LIBDIR}
    )
else()
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
endif()

if(BUILD_TESTING)
    add_subdirectory(test)
endif()

