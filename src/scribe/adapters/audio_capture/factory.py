from __future__ import annotations

import platform

from scribe.adapters.audio_capture.combined import CombinedCaptureBackend
from scribe.domain.protocols import AudioCaptureBackend


def create_audio_capture_backend() -> AudioCaptureBackend:
    system = platform.system()
    if system == "Windows":
        from scribe.adapters.audio_capture.windows_wasapi import (
            WindowsWasapiCaptureBackend,
        )

        return CombinedCaptureBackend(WindowsWasapiCaptureBackend(), system)
    if system in {"Darwin", "Linux"}:
        from scribe.adapters.audio_capture.portaudio import (
            PortAudioCaptureBackend,
        )

        return CombinedCaptureBackend(PortAudioCaptureBackend(system), system)

    from scribe.adapters.audio_capture.unavailable import (
        UnavailableCaptureBackend,
    )

    return UnavailableCaptureBackend(
        platform_name=system,
        reason=f"Native audio capture is not implemented for {system}.",
    )
