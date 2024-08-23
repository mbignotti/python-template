import logging
from pathlib import Path

from dynaconf import Dynaconf

logger = logging.getLogger(__name__)


def load_config(config_root_path: str | None) -> Dynaconf:
    config_root_path = Path(__file__).parent.parent / "config" if config_root_path is None else Path(config_root_path)
    abs_config_path = config_root_path.absolute()
    return Dynaconf(
        settings_files=[abs_config_path / "**/*.toml"],
        # variables exported as `DYNACONF_FOO=bar` becomes `settings.FOO == "bar"`
        envvar_prefix="DYNACONF",
        environments=True,
        # to switch environments `export ENV_FOR_DYNACONF=production`
        env_switcher="ENV_FOR_DYNACONF",
        load_dotenv=True,
        merge_enable=True,
    )
