import Foundation
import ImageIO
import UniformTypeIdentifiers

/// A type that provides access to the metadata of an image.
public struct ImageMetadata: Metadata {
    /// 
    public private(set) var options: MetadataOptions = .all
    
    // MARK: - Properties
    
    /// The number of bits in each color sample of each pixel.
    public var bitDepth: Int? {
        rawValue[kCGImagePropertyDepth] as? Int
    }
    
    /// The size of the image in bytes.
    public var bytes: Int? {
        rawValue[kCGImagePropertyFileSize] as? Int
    }
    
    /// The size of the image as a `Measurement` type.
    public var bytesMeasurement: Measurement<UnitInformationStorage>? {
        guard let bytes else { return nil }
        return Measurement(value: Double(bytes), unit: .bytes)
    }
    
    /// The color model of the image such as "RGB", "CMYK", "Gray", or "Lab".
    public var colorModel: String? {
        rawValue[kCGImagePropertyColorModel] as? String
    }
    
    /// The name of any optional ICC profile embedded in the image.
    public var colorProfile: String? {
        rawValue[kCGImagePropertyProfileName] as? String
    }
    
    /// The content type of the image.
    public private(set) var contentType: UTType?
    
    /// The resolution, in dots per inch, in the y dimension.
    public var dpiHeight: Int? {
        rawValue[kCGImagePropertyDPIHeight] as? Int
    }
    
    /// The resolution, in dots per inch, in the x dimension.
    public var dpiWidth: Int? {
        rawValue[kCGImagePropertyDPIWidth] as? Int
    }
    
    /// True if the image contains an alpha (a.k.a. coverage) channel.
    public var hasAlpha: Bool {
        rawValue[kCGImagePropertyHasAlpha] as? Bool ?? false
    }
    
    /// True if the image contains floating-point pixel samples.
    public var isFloat: Bool {
        rawValue[kCGImagePropertyIsFloat] as? Bool ?? false
    }
    
    /// True if the image contains indexed (a.k.a. paletted) pixel samples.
    public var isIndexed: Bool {
        rawValue[kCGImagePropertyIsIndexed] as? Bool ?? false
    }
    
    /// The decoded byte size of the image.
    public var memorySize: String? {
        bytes?.formatted(
            .byteCount(
                style: .memory,
                spellsOutZero: true,
                includesActualByteCount: true
            )
        )
    }
    
    /// The intended display orientation of the image.
    public var orientation: ImageOrientation? {
        guard let value = rawValue[kCGImagePropertyOrientation] as? UInt32 else { return nil }
        return ImageOrientation(rawValue: value)
    }
    
    /// For information about how to interpret this value, see the PixelFormat tag in the EXIF specification.
    public var pixelFormat: Int? {
        rawValue[kCGImagePropertyPixelFormat] as? Int
    }
    
    /// The number of pixels along the y-axis of the image.
    public var pixelHeight: Int? {
        rawValue[kCGImagePropertyPixelHeight] as? Int
    }
    
    /// The number of pixels along the x-axis of the image.
    public var pixelWidth: Int? {
        rawValue[kCGImagePropertyPixelWidth] as? Int
    }
    
    /// Metadata for an image that uses Exchangeable Image File Format (EXIF).
    public var exif: EXIF? {
        guard let exifDictionary = rawValue[kCGImagePropertyExifDictionary] as? NSDictionary else { return nil }
        return EXIF(rawValue: exifDictionary)
    }
    
    /// Metadata for an image that uses International Press Telecommunications Council (IPTC) metadata.
    public var iptc: IPTC? {
        guard let iptcDictionary = rawValue[kCGImagePropertyIPTCDictionary] as? NSDictionary else { return nil }
        return IPTC(rawValue: iptcDictionary)
    }
    
    /// Metadata for the Tagged Image File Format (TIFF).
    public var tiff: TIFF? {
        guard let tiffDictionary = rawValue[kCGImagePropertyTIFFDictionary] as? NSDictionary else { return nil }
        return TIFF(rawValue: tiffDictionary)
    }
    
    /// Metadata for an image that has Global Positioning System (GPS) information.
    public var gps: GPS? {
        guard let gpsDictionary = rawValue[kCGImagePropertyGPSDictionary] as? NSDictionary else { return nil }
        return GPS(rawValue: gpsDictionary)
    }
    
    public private(set) var imageFile: ImageFile?
    
    // MARK: - RawRepresentable
    
    public typealias RawValue = NSDictionary
    
    public init(rawValue: NSDictionary) {
        self.rawValue = rawValue
    }
    
    public let rawValue: NSDictionary
}

extension ImageMetadata {
    /// Creates a new `ImageMetadata` from a URL.
    /// - Parameter url:A file URL.
    ///- Parameter options: Metadata parsing options.
    public init(url: URL, options: MetadataOptions = .all) throws {
        let imageFile = try ImageFile(url: url)
        self = try .init(imageFile: imageFile, options: options)
    }
    
    /// Creates a new `ImageMetadata` from an ``ImageFile``.
    /// - Parameter imageFile: The source ``ImageFile``.
    /// - Parameter options: Metadata parsing options.
    public init(imageFile: ImageFile, options: MetadataOptions = .all) throws(MetadataError) {
        guard let imageSource = CGImageSourceCreateWithURL(imageFile.url as CFURL, nil) else {
            throw MetadataError.invalidImageSource
        }

        try self.init(imageSource: imageSource, options: options)
        self.imageFile = imageFile
    }
    
    /// Creates a new `ImageMetadata` from a `CGImageSource`.
    /// - Parameters:
    ///   - imageSource: The `CGImageSource`.
    ///   - options: Metadata parsing options.
    public init(imageSource: CGImageSource, options: MetadataOptions = .all) throws(MetadataError) {
        guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as NSDictionary? else {
            throw MetadataError.invalidImageProperties
        }
        self = .init(rawValue: properties)
        self.options = options
        
        if let contentType = CGImageSourceGetType(imageSource) as? String {
            self.contentType = UTType(contentType)
        }
    }
}

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
        case imageFile
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
        
        try container.encodeIfPresent(imageFile, forKey: .imageFile)
    }
}

