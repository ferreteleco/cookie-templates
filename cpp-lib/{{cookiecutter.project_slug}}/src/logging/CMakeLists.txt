set(
   logging_tools_sources_list
   {%- if cookiecutter.library_type == 'shared' %}
   ${CMAKE_CURRENT_SOURCE_DIR}/init_logging_dynamic.cpp
   {%- endif %}
   ${CMAKE_CURRENT_SOURCE_DIR}/spdlog_config.cpp
  PARENT_SCOPE
)