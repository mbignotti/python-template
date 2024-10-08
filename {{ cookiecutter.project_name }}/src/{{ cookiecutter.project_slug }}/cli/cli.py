import importlib.metadata
import os

import typer
from loguru import logger
from rich.logging import RichHandler

from {{ cookiecutter.project_slug }}.config import load_config

__version__ = importlib.metadata.version("{{ cookiecutter.project_slug }}")

config_root_path = os.getenv("CONFIG_ROOT_PATH", None)

settings = load_config(config_root_path)

logger.configure(handlers=[{"sink": RichHandler(level=settings.logging.level), "format": "{message}"}])


app = typer.Typer()


@app.callback(invoke_without_command=True)
def main() -> None:
    logger.info(f"Welcome to the {{ cookiecutter.project_name }} project! \n\n--- Version {__version__} ---")
