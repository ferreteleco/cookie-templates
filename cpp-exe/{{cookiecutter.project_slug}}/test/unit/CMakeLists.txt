# Target name
set(UNIT_TEST_BIN ${PROJECT_NAME}_unit_tests PARENT_SCOPE)

# Target sources
set(
  test_bin_sources
  ${CMAKE_SOURCE_DIR}/src/{{cookiecutter.project_slug}}.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/{{cookiecutter.project_slug}}_tests.cpp
)

# Make test executable
# Add tests source files after main
add_executable(
  ${UNIT_TEST_BIN}
  ${TEST_BIN_SOURCES}
)

target_include_directories(
  ${UNIT_TEST_BIN}
  PRIVATE
    ${CMAKE_SOURCE_DIR}/src
)

# Link catch library for test running
# Link project library for testing
target_link_libraries(
  ${UNIT_TEST_BIN}
  PRIVATE
    Catch2::Catch2WithMain
)

target_compile_options(
  ${UNIT_TEST_BIN}
  PRIVATE
    "-Wall" "-pedantic" "-Wextra"
)
