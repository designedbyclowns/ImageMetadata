extension ImageMetadata: Encodable {
    enum CodingKeys: String, CodingKey {
        case bitDepth
        case bytes
        case colorModel
        case colorProfile
        case contentType
        case dpiHeight
        case dpiWidth
        case hasAlpha
        case isFloat
        case isIndexed
        case memorySize
        case orientation
        case pixelFormat
        case pixelHeight
        case pixelWidth
        
        case exif
        case iptc
        case tiff
        case gps
        case dng
        case png
        case imageFile = "file"
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(bitDepth, forKey: .bitDepth)
        try container.encodeIfPresent(bytes, forKey: .bytes)
        try container.encodeIfPresent(colorModel, forKey: .colorModel)
        try container.encodeIfPresent(colorProfile, forKey: .colorProfile)
        try container.encodeIfPresent(contentType?.identifier, forKey: .contentType)
        try container.encodeIfPresent(dpiHeight, forKey: .dpiHeight)
        try container.encodeIfPresent(dpiWidth, forKey: .dpiHeight)
        try container.encode(hasAlpha, forKey: .hasAlpha)
        try container.encode(isFloat, forKey: .isFloat)
        try container.encode(isIndexed, forKey: .isIndexed)
        try container.encodeIfPresent(memorySize, forKey: .memorySize)
        try container.encodeIfPresent(orientation?.description, forKey: .orientation)
        try container.encodeIfPresent(pixelFormat, forKey: .pixelFormat)
        try container.encodeIfPresent(pixelHeight, forKey: .pixelHeight)
        try container.encodeIfPresent(pixelWidth, forKey: .pixelWidth)
        
        if options.contains(.exif) {
            try container.encodeIfPresent(exif, forKey: .exif)
        }
        
        if options.contains(.iptc) {
            try container.encodeIfPresent(iptc, forKey: .iptc)
        }
        
        if options.contains(.tiff) {
            try container.encodeIfPresent(tiff, forKey: .tiff)
        }
        
        if options.contains(.gps) {
            try container.encodeIfPresent(gps, forKey: .gps)
        }

        if options.contains(.dng) {
            try container.encodeIfPresent(dng, forKey: .dng)
        }

        if options.contains(.png) {
            try container.encodeIfPresent(png, forKey: .png)
        }

        if let imageFile {
            var fileContainer = encoder.container(keyedBy: ImageFile.CodingKeys.self)
            try fileContainer.encodeIfPresent(imageFile.filename, forKey: .filename)
            try fileContainer.encodeIfPresent(imageFile.formattedFileSize, forKey: .fileSize)
        }
    }
}
