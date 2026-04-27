# AGENTS.md

Guidance for AI coding agents working in this repository.

## Project

Swift Package providing the `ImageMetadata` library and the `imgmd` macOS CLI. It reads (read-only) image metadata via Apple's ImageIO framework, so supported formats and tags are constrained to what ImageIO exposes.

- swift-tools-version: 6.2
- Platforms: macOS 15, iOS 18, watchOS 11, tvOS 18
- Default localization: en-US
- Upcoming feature `InternalImportsByDefault` is enabled package-wide (see the loop at the bottom of `Package.swift`). This means `import Foo` is internal by default — use `public import` in source files when a type from the imported module appears in a public API.

## Common commands

```sh
swift build                  # debug build
swift test                   # run all tests (Swift Testing, not XCTest)
swift test --filter EXIFTests                    # run a single test struct
swift test --filter EXIFTests/apertureValue      # run a single test
make build                   # release build into ./.build
make install                 # release build + install imgmd to /usr/local/bin
make clean                   # rm -rf ./.build
```

The `imgmd` binary can also be exercised directly during development:

```sh
swift run imgmd ./Sources/Shared/Resources/WindowAtLeGras.jpg
```

## Architecture

### Library layout

The `ImageMetadata` target wraps the dictionary-based output of `CGImageSourceCopyPropertiesAtIndex` in strongly-typed, `Codable` Swift values. The flow is:

1. `ImageFile` validates a file URL (security-scoped access, content-type check against `.image`, file size).
2. `ImageMetadata.init(url:options:)` → `init(imageFile:)` → `init(imageSource:)` → `init(rawValue: NSDictionary, options:)`. The `rawValue` initializer is the single ingestion point that pulls properties out of the ImageIO dictionary using `kCGImageProperty*` keys.
3. Sub-dictionaries (`kCGImagePropertyExifDictionary`, `IPTCDictionary`, `TIFFDictionary`, `GPSDictionary`, `DNGDictionary`, `PNGDictionary`, `GIFDictionary`, `8BIMDictionary`) are decoded into `EXIF`, `IPTC`, `TIFF`, `GPS`, `DNG`, `PNG`, `GIF`, `EightBIM` structs only when the matching `MetadataOptions` flag is set.

`MetadataOptions` is an `OptionSet` (`.exif`, `.iptc`, `.tiff`, `.gps`, `.dng`, `.png`, `.gif`, `.eightBIM`, `.all`, `.none`) that gates which sub-metadata blocks are populated. The CLI re-maps its `--exif/--no-exif` style flags onto this option set.

### The `Metadata` protocol

Every public metadata type (`ImageMetadata`, `ImageFile`, `EXIF`, `IPTC`, `TIFF`, `GPS`, `DNG`, `PNG`, `GIF`, `EightBIM`) conforms to `Metadata: Encodable & CustomStringConvertible & Sendable`. The protocol's default `description` JSON-encodes `self` with `.iso8601` dates, sorted keys, and pretty printing — that's what `imgmd` ultimately prints. Encoding behavior for each type is customized in dedicated `*+Encodable.swift` files; treat those as the source of truth for the JSON shape, not the stored properties. `DNG`'s encoder is intentionally lossy: large binary blobs (`originalRawFileData`, ICC profiles, opcode lists, `privateData`) and the linearization table are emitted as integer byte/entry counts rather than their raw bytes; `GIF` does the same with `imageColorMap`.

### Sub-metadata structure

Each metadata family lives in its own folder and follows the same pattern:

- `EXIF/`, `IPTC/`, `TIFF/`, `GPS/`, `DNG/`, `PNG/`, `GIF/`, `EightBIM/` — one struct per family plus an `*+Encodable.swift` and any enum types modeling EXIF's integer-coded fields (`ExposureMode`, `WhiteBalance`, `SceneCaptureType`, `LightSource`, etc., each `RawRepresentable<Int>`).
- `GPS/GPS+CoreLocation.swift` provides interop with `CoreLocation`.
- `Extensions/Calendar.swift`, `Extensions/TimeZone.swift` — date parsing helpers used to assemble `Date` values from EXIF's split `DateTime* + SubsecTime* + OffsetTime*` fields. Date assembly is subtle (see prior commit history around date parsing); when changing it, run `EXIFTests` and the root-level `CalendarTests.swift` to catch regressions.

### Errors

`MetadataError` and `ImageFileError` are the only public error types. `ImageFileError` uses typed throws (`throws(ImageFileError)`) and carries a URL plus an enum code; `ImageMetadata`'s init chain also uses typed throws (`throws(MetadataError)`). Preserve typed-throws signatures when modifying these initializers — callers depend on them.

### CLI (`imgmd`)

`Sources/imgmd/imgmd.swift` is a single `ParsableCommand`. The flag-to-option mapping lives in `run()`:
- `--basic` forces `MetadataOptions.none`.
- If no metadata flag is set, defaults to `.all`.
- For each input file the CLI also auto-adds `.dng` to that file's options when its UTI conforms to `UTType.dng` (looked up via `URL.resourceValues(forKeys: [.contentTypeKey])`). `--basic` suppresses this auto-include.
- `--debug` short-circuits to printing the raw ImageIO dictionary via `ImageMetadata.getProperties(url:)`.

## Tests

Tests use **Swift Testing** (`import Testing`, `@Test`), not XCTest. Two test targets:

- `ImageMetadataTests` — unit tests for each metadata family. Most tests construct an `NSDictionary` of `kCGImageProperty*` keys directly (see `EXIFTests.sampleRawEXIF()`) so they don't need real image files. They `@testable import` both `ImageMetadata` and `Shared`.
- `imgmdTests` — tests for the CLI target.

Test fixtures (sample JPEGs) live in `Sources/Shared/Resources/` and are accessed through `Shared.url(forResource:withExtension:)`, which wraps `Bundle.module`. Add new fixtures there, not under `Tests/`.

Swift Package Manager only compiles `.swift` files inside a target's source path (`Tests/<TargetName>/...`). Loose files at `Tests/foo.swift` or the repo root are silently ignored — always place new tests inside `Tests/ImageMetadataTests/` or `Tests/imgmdTests/`.

## CI

`.github/workflows/swift.yml` runs `swift build` and `swift test` on `macos-latest` for pushes and PRs to `main`.
