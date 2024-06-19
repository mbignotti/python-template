from template.cli import cli

__app_name__ = "template"


def main() -> None:
    cli.app(prog_name=__app_name__)
