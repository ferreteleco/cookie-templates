"""Post-generate hook for cookiecutter."""

from os import listdir, makedirs
from os.path import join
from pathlib import Path
import shutil

import logging


def remove_pyenv_version_file():

    generate_pyenv_file = {{cookiecutter.generate_pyenv_file}}

    if generate_pyenv_file == False:
        LOG.info("Skipping .python-version file generation (pyenv) ...")
        path = Path("./.python-version")
        path.unlink()


def remove_pyproject_file():

    generate_poetry_file = {{cookiecutter.generate_poetry_file}}

    if generate_poetry_file == False:
        LOG.info("Skipping pyproject.toml file generation (Poetry) ...")
        path = Path("./pyproject.toml")
        path.unlink()


def remove_vscode_project_files():

    vscode_project = {{cookiecutter.vscode_project}}

    if vscode_project == True:
        LOG.info("Generating .vscode folder (VSCode) with default tasks.json ...")
        vscode_files = join("_", "vscode")

        for file_or_folder in listdir(vscode_files):
            makedirs(".vscode", exist_ok=True)
            shutil.move(
                join(vscode_files, file_or_folder), join(".vscode", file_or_folder)
            )

    else:
        LOG.info("Skipping .vscode file generation (VSCode) ...")


def set_up_license():
    """Get license text and put it in project root."""
    license_type = "{{ cookiecutter.license }}"

    LOG.info("Moving %s license ...", license_type)
    license_file = join("_", "licenses", license_type)
    shutil.move(license_file, "./LICENSE")


def clean():
    """Remove files and folders only needed as input for generation."""
    LOG.info("Removing input data folder ...")
    shutil.rmtree("_")


def change_line_endings_CRLF_to_LF():
    for path in Path(".").glob("**/*"):
        if path.is_file():
            data = path.read_bytes()
            lf_data = data.replace(b"\r\n", b"\n")
            path.write_bytes(lf_data)


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG, format="%(message)s")
    LOG = logging.getLogger("post_gen_project")

    remove_pyenv_version_file()
    remove_pyproject_file()
    remove_vscode_project_files()
    set_up_license()
    clean()
    change_line_endings_CRLF_to_LF()
