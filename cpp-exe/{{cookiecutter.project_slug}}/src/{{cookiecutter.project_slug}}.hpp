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


#ifndef {{cookiecutter.project_slug.upper()}}_HPP
#define {{cookiecutter.project_slug.upper()}}_HPP

/**
 * @brief Main namespace.
 *
 */
namespace {{cookiecutter.project_slug}} {
  
  /**
   * @brief Adds two integers.
   *
   * @param a the first integer
   * @param b the second integer
   * @return the result
   */
  int add(const int &a, const int &b);

} // namespace {{cookiecutter.project_slug}}

#endif /* {{cookiecutter.project_slug.upper()}}_HPP */
