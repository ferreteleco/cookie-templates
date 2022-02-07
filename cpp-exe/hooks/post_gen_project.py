"""Post-generate hook for cookiecutter."""

from os.path import join
from pathlib import Path
import shutil

import logging


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

    set_up_license()
    clean()
    change_line_endings_CRLF_to_LF()
