# Using ImageMetadata

Getting started with ImageMetadata.

## Overview

To access the metadata for an image file, initialize an ``ImageMetadata`` with a file URL.

### Example

The example uses [View from the Window at Le Gras](https://en.wikipedia.org/wiki/View_from_the_Window_at_Le_Gras) by Joseph Nicéphore Niépce – the earliest surviving camera photograph.

![View from the Window at Le Gras.](WindowAtLeGras)

Create an ImageMetadata type from a file URL:

```swift
import Foundation
import ImageMetadata

let url = URL(fileURLWithPath: "WindowAtLeGras.jpg")

do {
    let metadata = try ImageMetadata(url: url)
} catch {
    print(error.localizedDescription)
}
let metadata = try? ImageMetadata(url: url)
```

Accessing properties:

```swift
let headline = metadata.iptc?.headline // "View from the Window at Le Gras"
let city = metadata.iptc?.city // "Saint-Loup-de-Varennes"
let country = metadata.iptc?.country // "France"
let year = metadata.exif?.dateTimeOriginal?.formatted(Date.FormatStyle().year(.defaultDigits)) // "1826"
let byline = metadata.iptc?.byline?.first // "Joseph Nicéphore Niépce"
let caption = metadata.iptc?.captionAbstract // "The earliest surviving camera photograph."
```

View all metadata as JSON:

```swift
metadata?.description
```

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
    "path" : "Resources/WindowAtLeGras.jpg",
    "url" : "file:///Resources/WindowAtLeGras.jpg"
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


