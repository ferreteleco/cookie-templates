/**
 * spdlog_config.hpp
 * {{cookiecutter.project_name}}
 *
 * Maintainer {{cookiecutter.full_name}} ({{cookiecutter.email}})
 *
 * Created @ {% now 'utc', '%A, %dth %B %Y %I:%M:%S %p' %}
 * Copyright (c) {% now "utc", "%Y " -%} {{cookiecutter.full_name}}
 * {%- if cookiecutter.license  == 'Propietary' -%}All Rights Reserved {%- else -%} This software is released under the <<license>> license.{%- endif -%}
 */

#include <spdlog/spdlog.h>
#include <spdlog/sinks/stdout_color_sinks.h>
/* - Impl. Notes (20220524-aferreiro) Lib logger name
* This define controls the name of the spdlog logger used inside the library.
*
* Ref. https://stackoverflow.com/a/12053689
*/
#define {{cookiecutter.project_acronym}}_LOG_NAME "{{cookiecutter.project_slug.replace('_', '-')}}"

/**
 * @brief Main namespace.
 *
 */
namespace {{cookiecutter.project_slug}} {

  /**
  * @brief Logging namespace.
  */
  namespace logging {

    /**
     * @brief This function configures logging for the library.
     *
     * @details It defaults to a logger named "my-lib" that is defined in macro {{cookiecutter.project_acronym}}_LOG_NAME. By
     * using this function, the default (silent) logger is replaced by a new one with similar name
     * and configurable parameters as defined below:
     *
     * LOGGING can be performed inside the library using the following macros:
     *
     * - SPDLOG_LOGGER_TRACE(spdlog::get({{cookiecutter.project_acronym}}_LOG_NAME), "message")
     * - SPDLOG_LOGGER_DEBUG(spdlog::get({{cookiecutter.project_acronym}}_LOG_NAME), "message")
     * - SPDLOG_LOGGER_INFO(spdlog::get({{cookiecutter.project_acronym}}_LOG_NAME), "message")
     * - SPDLOG_LOGGER_WARN(spdlog::get({{cookiecutter.project_acronym}}_LOG_NAME), "message")
     * - SPDLOG_LOGGER_ERROR(spdlog::get({{cookiecutter.project_acronym}}_LOG_NAME), "message")
     * - SPDLOG_LOGGER_CRITICAL(spdlog::get({{cookiecutter.project_acronym}}_LOG_NAME), "message")
     *
     * Only "message" has to be modified as needed. For more information on variable substitition in
     * message, see https://github.com/gabime/spdlog/wiki/1.-QuickStart
     *
     * Because spdlog is header-only, building shared libraries and using it in a main program will
     * not share the registry between them. This means that calls to functions like
     * spdlog::set_level(spdlog::level::level_enum::info) will not change loggers in DLLs.
     *
     * What can be done is to register the logger in both registries.
     *
     * Ref. https://github.com/gabime/spdlog/wiki/How-to-use-spdlog-in-DLLs
     *
     * @param screen_log_level Logging level for the screen (console) sink. It accepts values
     * between 0 and 6 (from more verbose to off).
     * @param file_log_level Logging level for the file sink. It accepts values between 0 and 6
     * (from more verbose to off). It defaults to INFO.
     * @param file_location Location for the file sink of the logger. It defaults to a file in the
     * cwd named "shipmate_terminal.log"
     */
    std::shared_ptr<spdlog::logger> configure_logging(const uint8_t screen_log_level,
      const uint8_t file_log_level = 3, const std::string &file_location = "logfile.log");
  }
}