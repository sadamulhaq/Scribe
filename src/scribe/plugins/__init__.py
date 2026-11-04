"""Public extension API for Scribe plugins.

Community packages should import contracts from this module rather than from
application or infrastructure internals. The API is versioned independently so
plugins can fail with a clear compatibility message after a future upgrade.
"""

from scribe.domain.entities import (
    DiarizationSegment,
    SegmentDraft,
    SummaryResult,
    TranscriptionEngineRequest,
    TranscriptionResult,
)
from scribe.domain.protocols import (
    CancellationCheck,
    DiarizationEngine,
    EmbeddingProvider,
    ProgressReporter,
    SegmentReporter,
    SummaryEngine,
    TranscriptionEngine,
)

from .contracts import (
    PLUGIN_API_VERSION,
    AnalysisArtifact,
    HookContext,
    MeetingDocument,
    PluginManifest,
    PluginSettingField,
    ProviderDescriptor,
    ProviderKind,
    ProviderModel,
    ProviderRuntimeContext,
    TranscriptDocumentSegment,
    VectorStoreCatalog,
    VectorStoreDescriptor,
    VectorStoreOperation,
)
from .manager import PluginRegistrar
from .providers import ProviderFactory

__all__ = [
    "PLUGIN_API_VERSION",
    "AnalysisArtifact",
    "CancellationCheck",
    "DiarizationEngine",
    "DiarizationSegment",
    "EmbeddingProvider",
    "HookContext",
    "MeetingDocument",
    "PluginManifest",
    "PluginRegistrar",
    "PluginSettingField",
    "ProgressReporter",
    "ProviderDescriptor",
    "ProviderFactory",
    "ProviderKind",
    "ProviderModel",
    "ProviderRuntimeContext",
    "SegmentDraft",
    "SegmentReporter",
    "SummaryEngine",
    "SummaryResult",
    "TranscriptDocumentSegment",
    "TranscriptionEngine",
    "TranscriptionEngineRequest",
    "TranscriptionResult",
    "VectorStoreCatalog",
    "VectorStoreDescriptor",
    "VectorStoreOperation",
]
