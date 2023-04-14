# Find catch library
find_package(Catch2 3.0.0 REQUIRED)

add_subdirectory(unit)

# Add tests target
add_custom_target(
  tests
  DEPENDS
    ${UNIT_TEST_BIN}
)
