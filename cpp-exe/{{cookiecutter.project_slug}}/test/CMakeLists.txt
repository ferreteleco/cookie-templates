# Find catch library
find_package(Catch2 3.0.0 REQUIRED)

set(TEST_BIN ${PROJECT_NAME}_test)

set(TEST_BIN_SOURCES
  ${CMAKE_SOURCE_DIR}/src/{{cookiecutter.project_slug}}.cpp
)

# Make test executable
# Add tests source files after main
add_executable(
  ${TEST_BIN}
  ${TEST_BIN_SOURCES}
  {{cookiecutter.project_slug}}_tests.cpp
)

target_include_directories(
  ${TEST_BIN}
  PRIVATE
    ${CMAKE_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# Link catch library for test running
# Link project library for testing
target_link_libraries(
  ${TEST_BIN}
  PRIVATE
    Catch2::Catch2WithMain
)

target_compile_options(
  ${TEST_BIN}
  PRIVATE
    "-Wall" "-pedantic" "-Wextra"
)

# Add tests target
add_custom_target(
  tests
  DEPENDS
    ${TEST_BIN}
)
