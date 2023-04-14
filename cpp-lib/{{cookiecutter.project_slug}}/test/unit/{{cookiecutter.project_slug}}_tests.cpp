/**
 * {{cookiecutter.project_slug}}_tests.hpp
 * {{cookiecutter.project_name}}
 *
 * Maintainer {{cookiecutter.full_name}} ({{cookiecutter.email}})
 *
 * Created @ {% now 'utc', '%A, %dth %B %Y %I:%M:%S %p' %}
 * Copyright (c) {% now "utc", "%Y " -%} {{cookiecutter.full_name}}
 * {%- if cookiecutter.license == 'Propietary' %} All Rights Reserved.{%- else %} This software is released under the {{cookiecutter.license}} license.{%- endif %}
 */

#include <catch2/catch_all.hpp>

#include "{{cookiecutter.project_slug}}/{{cookiecutter.project_slug}}.hpp"

TEST_CASE("add") {
  REQUIRE({{cookiecutter.project_slug}}::add(1, 1) == 2);
}
