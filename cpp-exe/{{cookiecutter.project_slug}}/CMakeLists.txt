# Project Properties
cmake_minimum_required (VERSION 3.10.2 FATAL_ERROR)
project(
  {{ cookiecutter.project_slug }}
  VERSION
    {{ cookiecutter.version }}
  LANGUAGES
    CXX
)

# Build release by default
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

# Installation directory
include(GNUInstallDirs)
set(CMAKE_INSTALL_CONFIGDIR "${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}/cmake")

# Add Build Targets
add_subdirectory(src)
add_subdirectory(test)

