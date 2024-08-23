from {{ cookiecutter.project_slug }}.cli import cli

__app_name__ = "{{ cookiecutter.project_slug }}"


def main() -> None:
    cli.app(prog_name=__app_name__)
