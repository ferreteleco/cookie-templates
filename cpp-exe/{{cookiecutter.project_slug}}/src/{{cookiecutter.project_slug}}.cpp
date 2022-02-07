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


#include "{{cookiecutter.project_slug}}.hpp"

namespace {{cookiecutter.project_slug}} {

  int add(const int &a, const int &b) {
    return a + b;
  }

}