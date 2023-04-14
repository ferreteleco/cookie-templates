# Find catch library
find_package(Catch2 3.0.0 REQUIRED)

# Target name
set(UNIT_TEST_BIN ${PROJECT_NAME}_unit_tests)
add_subdirectory(unit)

# Add tests target
add_custom_target(
  tests
  DEPENDS
    ${UNIT_TEST_BIN}
)
