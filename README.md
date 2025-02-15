# ImageMetadata

A swift library and macOS command line tool for reading metadata from images.

## ImageMetadata swift library

This library uses Apple's ImageIO framework to access metadata directly from an image. As such it is limited to the image formats and metadata tags, supported by that framework.

_Note: It only supports the reading of tag values._

### Installation

Add the package as a dependency in your Package.swift file

```swift
let package = Package(
    name: "Foo",
    // name, platforms, products, etc.
    dependencies: [
        .package(url: "https://github.com/designedbyclowns/ImageMetadata",  .upToNextMinor(from: "0.1.0")),
    ],
    targets: [
        .target(name: "Foo", dependencies: [
            .product(name: "ImageMetadata", package: "ImageMetadata"),
        ]),
    ]
)
```

Usage:

```swift
import ImageIO

let imageFile = try ImageFile(path: "WindowAtLeGras.jpg")
let metadata = try ImageMetadata(url: imageFile.url)
print(metadata?.description)
```

Build and view the documentation for more details.


## imgmd – command line tool

The `imgmd` command line tool outputs metadata for the provided file(s) as JSON. It utilizes the ImageTool swift library and is primarily intended to help with debugging.

### Installation

Clone the repo then:

```sh
make install
```

Or using swift:

```
swift build -c release
cp .build/release/imgmd /usr/local/bin/imgmd
```

### Usage

```sh
imgmd --help
OVERVIEW: Extract image metadata.

Outputs metadata from the supplied image files as JSON.

USAGE: imgmd [--basic] [--exif] [--no-exif] [--gps] [--no-gps] [--iptc] [--no-iptc] [--tiff] [--no-tiff] [--debug] [<files> ...]

ARGUMENTS:
  <files>                 Image files.

OPTIONS:
  -b, --basic             Basic. Don't include other metadata.
  -e, --exif/--no-exif    Include EXIF metadata. (default: --exif)
  -g, --gps/--no-gps      Include GPS metadata. (default: --gps)
  -i, --iptc/--no-iptc    Include IPTC metadata. (default: --iptc)
  -t, --tiff/--no-tiff    Include TIFF metadata. (default: --tiff)
  -d, --debug             Show the raw metadata.
  -h, --help              Show help information.
```sh

Example:

```sh
imgmd ./Resources/WindowAtLeGras.jpg
```

Results 

```json 
{
  "bitDepth" : 8,
  "colorModel" : "RGB",
  "colorProfile" : "GIMP built-in sRGB",
  "contentType" : "public.jpeg",
  "dpiHeight" : 540,
  "exif" : {
    "colorSpace" : 1,
    "componentsConfiguration" : [
      1,
      2,
      3,
      0
    ],
    "dateTimeDigitized" : "2025-02-13T15:00:49Z",
    "dateTimeOriginal" : "1826-06-01T19:52:58Z",
    "flashPixVersion" : "1.0",
    "offsetTime" : "-08:00",
    "offsetTimeDigitized" : "-08:00",
    "offsetTimeOriginal" : "+02:00",
    "pixelXDimension" : 4530,
    "pixelYDimension" : 3810,
    "sceneCaptureType" : "Standard",
    "subsecTime" : "002",
    "subsecTimeDigitized" : "002",
    "subsecTimeOriginal" : "002",
    "version" : "2.2.1"
  },
  "gps" : {
    "dateTime" : "2025-02-13T15:02:45Z",
    "horizontalPositioningError" : 1,
    "latitude" : 46.72519666666667,
    "latitudeReference" : "N",
    "longitude" : 4.860291666666667,
    "longitudeReference" : "E"
  },
  "hasAlpha" : false,
  "imageFile" : {
    "basename" : "WindowAtLeGras",
    "contentType" : "public.jpeg",
    "fileSize" : "2.1 MB (2,240,988 bytes)",
    "filename" : "WindowAtLeGras.jpg",
    "path" : "Resources/WindowAtLeGras.jpg"
  },
  "iptc" : {
    "byline" : [
      "Joseph Nicéphore Niépce"
    ],
    "captionAbstract" : "The earliest surviving camera photograph.",
    "city" : "Saint-Loup-de-Varennes",
    "copyrightNotice" : "Public Domain",
    "country" : "France",
    "countryCode" : "FR",
    "digitalCreationDate" : "2025-02-13T15:00:49Z",
    "headline" : "View from the Window at Le Gras",
    "keywords" : [
      "History",
      "Photograhy",
      "Bitumen",
      "Camera Obscura",
      "Heliography"
    ],
    "objectName" : "View from the Window at Le Gras",
    "provinceState" : "Bourgogne-Franche-Comté"
  },
  "isFloat" : false,
  "isIndexed" : false,
  "orientation" : "up",
  "pixelHeight" : 3810,
  "pixelWidth" : 4530,
  "tiff" : {
    "artist" : "Joseph Nicéphore Niépce",
    "copyright" : "Public Domain",
    "dateTime" : "2025-02-13T15:34:57Z",
    "imageDescription" : "The earliest surviving camera photograph.",
    "orientation" : 1,
    "photometricInterpretation" : 2,
    "resolutionUnit" : 2,
    "software" : "Adobe Photoshop 26.3 (Macintosh)",
    "xResolution" : 540,
    "yResolution" : 540
  }
}
```

## Documentation

Documentation can be viewed in Xcode by selecting the package target and choosing __Product > Build Documentation__.

## Contributing

Pull requests are both welcome and encouraged! 

So are bug reports, feedback and suggestions.

Just don't be a jerk.
