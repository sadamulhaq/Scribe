from __future__ import annotations

from pathlib import Path

import pytest

from scribe.config import AppSettings
from scribe.domain.errors import ValidationError
from scribe.infrastructure.storage import MeetingStorage
from scribe.paths import AppPaths


def test_storage_refuses_directory_traversal(tmp_path: Path) -> None:
    paths = AppPaths.from_settings(
        AppSettings(
            data_dir=tmp_path / "data",
            models_dir=tmp_path / "models",
        )
    )
    paths.ensure()
    storage = MeetingStorage(paths, max_upload_bytes=1024)

    with pytest.raises(ValidationError, match="outside meeting storage"):
        storage.delete_meeting("../outside")
