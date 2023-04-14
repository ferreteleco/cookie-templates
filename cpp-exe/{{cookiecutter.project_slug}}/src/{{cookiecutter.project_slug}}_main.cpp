/**
 * {{cookiecutter.project_slug}}_main.cpp
 * {{cookiecutter.project_name}}
 *
 * Maintainer {{cookiecutter.full_name}} ({{cookiecutter.email}})
 *
 * Created @ {% now 'utc', '%A, %dth %B %Y %I:%M:%S %p' %}
 * Copyright (c) {% now "utc", "%Y " -%} {{cookiecutter.full_name}}
 * {%- if cookiecutter.license == 'Propietary' %} All Rights Reserved.{%- else %} This software is released under the {{cookiecutter.license}} license.{%- endif %}
 */


#include "{{cookiecutter.project_slug}}.hpp"

int main(int argc, char const *argv[])
{
  int a = {{cookiecutter.project_slug}}::add(3,2);
  return a;
}
