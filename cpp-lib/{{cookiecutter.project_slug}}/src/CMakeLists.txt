# Compilation configuration

{%- if cookiecutter.add_spdlog_utils == 'True' %}
add_subdirectory(logging)
{%- endif %}
add_library(
  ${PROJECT_NAME}
  {{ cookiecutter.library_type.upper() }}
  {{cookiecutter.project_slug}}.cpp
  {%- if cookiecutter.add_spdlog_utils == 'True' %}
  ${logging_tools_sources_list}
  {%- endif %}
)

target_include_directories(
  ${PROJECT_NAME}
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
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

# Installation configuration

install(
  TARGETS
    ${PROJECT_NAME}
  EXPORT
    ${PROJECT_NAME}Targets
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(
  EXPORT ${PROJECT_NAME}Targets
  NAMESPACE ${PROJECT_NAME}::
  DESTINATION ${CMAKE_INSTALL_CONFIGDIR}
)

install(
  DIRECTORY
    "${CMAKE_SOURCE_DIR}/include/${PROJECT_NAME}"
  DESTINATION
    ${CMAKE_INSTALL_INCLUDEDIR}
)

install(
  FILES
    "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    "${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  DESTINATION
    ${CMAKE_INSTALL_CONFIGDIR}
)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
	"${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
	VERSION ${VERSION}
	COMPATIBILITY SameMajorVersion
)

configure_package_config_file(
  "${PROJECT_SOURCE_DIR}/cmake/${PROJECT_NAME}Config.cmake.in"
	"${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
	INSTALL_DESTINATION ${CMAKE_INSTALL_CONFIGDIR}
)
