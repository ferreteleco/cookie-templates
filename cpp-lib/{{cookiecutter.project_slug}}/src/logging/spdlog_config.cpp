/**
 * spdlog_config.cpp
 * {{cookiecutter.project_name}}
 *
 * Maintainer {{cookiecutter.full_name}} ({{cookiecutter.email}})
 *
 * Created @ {% now 'utc', '%A, %dth %B %Y %I:%M:%S %p' %}
 * Copyright (c) {% now "utc", "%Y " -%} {{cookiecutter.full_name}}
 * All Rights Reserved
 *
 * This software is released under the {{cookiecutter.license}} license.
 */

#include <iostream>
#include <spdlog/sinks/basic_file_sink.h>
#include <spdlog/sinks/stdout_color_sinks.h>
#include "{{cookiecutter.project_slug}}/{{cookiecutter.project_slug}}.hpp"

namespace {{cookiecutter.project_slug}} {

  namespace logging {

    std::shared_ptr<spdlog::logger> configure_logging(const uint8_t screen_log_level,
      const uint8_t file_log_level, const std::string &file_location) {

      const std::string format = "[%H:%M:%S.%F%z] %n[tID %t] [%^%l%$] %!@%s.%#\n\t-> %v";

      try {

        auto base_logger = spdlog::get({{cookiecutter.project_acronym}}_LOG_NAME);        
        if (base_logger) {
          spdlog::drop({{cookiecutter.project_acronym}}_LOG_NAME);
        }

        if (screen_log_level > 6) {
          throw std::invalid_argument(
            "Logging level must be between 0 and 6, as of spdlog enum definition");
        }

        std::vector<spdlog::sink_ptr> sinks;
        auto console_sink = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
        console_sink->set_level(static_cast<spdlog::level::level_enum>(screen_log_level));
        console_sink->set_color_mode(spdlog::color_mode::always);
        console_sink->set_pattern(format);
        sinks.push_back(console_sink);

        if (file_log_level > 6) {
          throw std::invalid_argument(
            "Logging level must be between 0 and 6, as of spdlog enum definition");
        }
        if (file_log_level < 6) {
          auto file_sink = std::make_shared<spdlog::sinks::basic_file_sink_mt>(file_location);
          file_sink->set_level(static_cast<spdlog::level::level_enum>(file_log_level));
          file_sink->set_pattern(format);
          sinks.push_back(file_sink);
        }

        auto created_logger =
          std::make_shared<spdlog::logger>({{cookiecutter.project_acronym}}_LOG_NAME, begin(sinks), end(sinks));
        created_logger->flush_on(spdlog::level::trace);
        created_logger->set_level(spdlog::level::trace);
        spdlog::register_logger(created_logger);

        return created_logger;
      }

      catch (const spdlog::spdlog_ex &ex) {
        std::cerr << "LOGGING INIT ERROR!!! -> " << ex.what() << std::endl;
        throw;
      } catch (const std::invalid_argument &ex) {
        std::cerr << "LOGGING CONFIG VALIDATION ERROR!!! -> " << ex.what() << std::endl;
        throw;
      }
    }
  } // namespace logging
} // namespace {{cookiecutter.project_slug}}