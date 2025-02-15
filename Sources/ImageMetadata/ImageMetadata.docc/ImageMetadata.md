# ``ImageMetadata``

A swift library for reading metadata from images.

## Overview

This library uses Apple's [ImageIO](https://developer.apple.com/documentation/imageio) framework to read metadata directly from an image and expose those properties in type safe swift models.

> ImageMetadata is limited to the image formats, and metadata tags, supported by ImageIO.

## Getting Started

See <doc:Usage>.

## Topics

### Basic Metadata Types

- ``ImageMetadata``
- ``ImageFile``

### Specific Metadata Types

- ``EXIF``
- ``IPTC``
- ``TIFF``
- ``GPS``

### Creating an `ImageMetadata` type.

- ``ImageMetadata/init(url:options:)``
- ``ImageMetadata/init(imageFile:options:)``
- ``ImageMetadata/init(imageSource:options:)``

### Errors

- ``MetadataError``
- ``ImageFileError``


