# Compilation configuration

add_executable(
  ${PROJECT_NAME}
  {{cookiecutter.project_slug}}.cpp
  {{cookiecutter.project_slug}}_main.cpp
)

target_include_directories(
  ${PROJECT_NAME}
  PRIVATE
    ${CMAKE_SOURCE_DIR}/src
)

target_compile_features(
  ${PROJECT_NAME}
  PUBLIC
    cxx_std_{{cookiecutter.cpp_standard}}
)

target_compile_options(
  ${PROJECT_NAME}
  PRIVATE
    "-Wall" "-pedantic" "-Wextra"
)
