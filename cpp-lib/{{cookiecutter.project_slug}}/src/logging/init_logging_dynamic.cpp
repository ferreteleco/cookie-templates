
/**
 * init_logging_dynamic.cpp
 * {{cookiecutter.project_name}}
 *
 * Maintainer {{cookiecutter.full_name}} ({{cookiecutter.email}})
 *
 * Created @ {% now 'utc', '%A, %dth %B %Y %I:%M:%S %p' %}
 * Copyright (c) {% now "utc", "%Y " -%} {{cookiecutter.full_name}}
 * {%- if cookiecutter.license == 'Propietary' %} All Rights Reserved.{%- else %} This software is released under the {{cookiecutter.license}} license.{%- endif %}
 */

#include <stdio.h>
#include "{{cookiecutter.project_slug}}/{{cookiecutter.project_slug}}.hpp"

namespace {{cookiecutter.project_slug}} {

  namespace logging {

  void lib_logging_initialization() {

    /* - Impl. Notes (20210622-aferreiro) Initialization of library
     * This creates a base logger sink and replaces it as the default logger for the library.
     *
     * Error handling is not necessary since it is default, as said in:
     * https://github.com/gabime/spdlog/wiki/Error-handling
     */

    printf("Initializing Library logging\n");
    auto base_logger = spdlog::get({{cookiecutter.project_acronym}}_LOG_NAME);
    if (base_logger) {
      spdlog::drop({{cookiecutter.project_acronym}}_LOG_NAME);
    }
    auto vss_lib = spdlog::stderr_color_mt({{cookiecutter.project_acronym}}_LOG_NAME);
    vss_lib->set_level(spdlog::level::off);
    vss_lib->flush_on(spdlog::level::info);
  }

  void lib_logging_deinitialization() {

    /* - Impl. Notes (20210622-aferreiro) Deinitialization of library
     * Related: https://github.com/gabime/spdlog/issues/1224#issuecomment-530749191
     *
     */
    printf("De-initializing library logging\n");
    spdlog::shutdown();
  }
  } // namespace logging
} // namespace {{cookiecutter.project_slug}}