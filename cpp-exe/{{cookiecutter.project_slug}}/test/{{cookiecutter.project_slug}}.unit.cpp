/**
 * {{cookiecutter.project_slug}}.unit.hpp
 * {{cookiecutter.project_name}}
 *
 * Maintainer {{cookiecutter.full_name}} ({{cookiecutter.email}})
 *
 * Created @ {% now 'utc', '%A, %dth %B %Y %I:%M:%S %p' %}
 * Copyright (c) {% now "utc", "%Y " -%} {{cookiecutter.full_name}}
 * All Rights Reserved
 */


#include <catch2/catch_all.hpp>

#include "{{cookiecutter.project_slug}}.hpp"

TEST_CASE("add") {
  REQUIRE({{cookiecutter.project_slug}}::add(1, 1) == 2);
}
