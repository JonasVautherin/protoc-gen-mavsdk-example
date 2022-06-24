find_package(GTest REQUIRED)

add_executable(tests
    tests.cpp
    )

target_include_directories(tests
    PUBLIC
    ${GTEST_INCLUDE_DIRS}
    ${PROJECT_SOURCE_DIR}
    )

target_link_libraries(tests
    example_library
    ${GTEST_LIBRARIES}
    )
