public import Foundation
public import ImageIO
public import UniformTypeIdentifiers.UTType

/// A type that provides access to the metadata of an image.
public struct ImageMetadata: Metadata {
    /// 
    public private(set) var options: MetadataOptions = .all
        
    /// The number of bits in each color sample of each pixel.
    public let bitDepth: Int?
    
    /// The size of the image in bytes.
    public let bytes: Int?
    
    /// The size of the image as a `Measurement` type.
    public let bytesMeasurement: Measurement<UnitInformationStorage>?
    
    /// The color model of the image such as "RGB", "CMYK", "Gray", or "Lab".
    public let colorModel: String?
    
    /// The name of any optional ICC profile embedded in the image.
    public let colorProfile: String?
    
    /// The content type of the image.
    public private(set) var contentType: UTType?
    
    /// The resolution, in dots per inch, in the y dimension.
    public let dpiHeight: Int?
    
    /// The resolution, in dots per inch, in the x dimension.
    public let dpiWidth: Int?
    
    /// True if the image contains an alpha (a.k.a. coverage) channel.
    public let hasAlpha: Bool
    
    /// True if the image contains floating-point pixel samples.
    public let isFloat: Bool
    
    /// True if the image contains indexed (a.k.a. paletted) pixel samples.
    public let isIndexed: Bool
    
    /// The decoded byte size of the image.
    public let memorySize: String?
    
    /// The intended display orientation of the image.
    public let orientation: ImageOrientation?
    
    /// For information about how to interpret this value, see the PixelFormat tag in the EXIF specification.
    public let pixelFormat: Int?
    
    /// The number of pixels along the y-axis of the image.
    public let pixelHeight: Int?
    
    /// The number of pixels along the x-axis of the image.
    public let pixelWidth: Int?
    
    /// Metadata for an image that uses Exchangeable Image File Format (EXIF).
    public let exif: EXIF?
    
    /// Metadata for an image that uses International Press Telecommunications Council (IPTC) metadata.
    public let iptc: IPTC?
    
    /// Metadata for the Tagged Image File Format (TIFF).
    public let tiff: TIFF?
    
    /// Metadata for an image that has Global Positioning System (GPS) information.
    public let gps: GPS?

    /// Metadata for an image that uses Adobe's Digital Negative (DNG) raw format.
    public let dng: DNG?

    /// Metadata for an image that uses Portable Network Graphics (PNG) format.
    public let png: PNG?

    /// Metadata for an image that uses Graphics Interchange Format (GIF).
    public let gif: GIF?

    /// 8BIM (Photoshop image resource block) metadata. Often present in
    /// PSD files but also embedded in JPEGs and TIFFs touched by Photoshop.
    public let eightBIM: EightBIM?

    /// Metadata for High Efficiency Image Coding (HEIC) sequences (animated HEIC).
    public let heic: HEIC?

    /// Metadata for the JPEG File Interchange Format (JFIF) container.
    public let jfif: JFIF?

    /// Metadata for the WebP image format.
    public let webP: WebP?

    public private(set) var imageFile: ImageFile?
    

    public init(rawValue: NSDictionary, options: MetadataOptions = .all) {
        self.options = options
        
        self.bitDepth = rawValue[kCGImagePropertyDepth] as? Int
        self.bytes = rawValue[kCGImagePropertyFileSize] as? Int
        
        if let bytes = self.bytes {
            self.bytesMeasurement = Measurement(value: Double(bytes), unit: .bytes)
            self.memorySize = bytes.formatted(
                .byteCount(
                    style: .memory,
                    spellsOutZero: true,
                    includesActualByteCount: true
                )
            )
        } else {
            self.bytesMeasurement = nil
            self.memorySize = nil
        }
        
        self.colorModel = rawValue[kCGImagePropertyColorModel] as? String
        self.colorProfile = rawValue[kCGImagePropertyProfileName] as? String
        
        self.dpiHeight = rawValue[kCGImagePropertyDPIHeight] as? Int
        self.dpiWidth = rawValue[kCGImagePropertyDPIWidth] as? Int
        
        self.hasAlpha = rawValue[kCGImagePropertyHasAlpha] as? Bool ?? false
        self.isFloat = rawValue[kCGImagePropertyIsFloat] as? Bool ?? false
        self.isIndexed = rawValue[kCGImagePropertyIsIndexed] as? Bool ?? false
        
        if let value = rawValue[kCGImagePropertyOrientation] as? UInt32 {
            self.orientation = ImageOrientation(rawValue: value)
        } else {
            self.orientation = nil
        }
        
        self.pixelFormat = rawValue[kCGImagePropertyPixelFormat] as? Int
        self.pixelHeight = rawValue[kCGImagePropertyPixelHeight] as? Int
        self.pixelWidth = rawValue[kCGImagePropertyPixelWidth] as? Int
                
        if options.contains(.exif), let exifDictionary = rawValue[kCGImagePropertyExifDictionary] as? NSDictionary {
            let auxDictionary = rawValue[kCGImagePropertyExifAuxDictionary] as? NSDictionary
            self.exif = EXIF(rawValue: exifDictionary, aux: auxDictionary)
        } else {
            self.exif = nil
        }
        
        if options.contains(.iptc), let iptcDictionary = rawValue[kCGImagePropertyIPTCDictionary] as? NSDictionary {
            self.iptc = IPTC(rawValue: iptcDictionary)
        } else {
            self.iptc = nil
        }
        
        if options.contains(.tiff), let tiffDictionary = rawValue[kCGImagePropertyTIFFDictionary] as? NSDictionary {
            self.tiff = TIFF(rawValue: tiffDictionary)
        } else {
            self.tiff = nil
        }
        
        if options.contains(.gps), let gpsDictionary = rawValue[kCGImagePropertyGPSDictionary] as? NSDictionary {
            self.gps = GPS(rawValue: gpsDictionary)
        } else {
            self.gps = nil
        }

        if options.contains(.dng), let dngDictionary = rawValue[kCGImagePropertyDNGDictionary] as? NSDictionary {
            self.dng = DNG(rawValue: dngDictionary)
        } else {
            self.dng = nil
        }

        if options.contains(.png), let pngDictionary = rawValue[kCGImagePropertyPNGDictionary] as? NSDictionary {
            self.png = PNG(rawValue: pngDictionary)
        } else {
            self.png = nil
        }

        if options.contains(.gif), let gifDictionary = rawValue[kCGImagePropertyGIFDictionary] as? NSDictionary {
            self.gif = GIF(rawValue: gifDictionary)
        } else {
            self.gif = nil
        }

        if options.contains(.eightBIM), let eightBIMDictionary = rawValue[kCGImageProperty8BIMDictionary] as? NSDictionary {
            self.eightBIM = EightBIM(rawValue: eightBIMDictionary)
        } else {
            self.eightBIM = nil
        }

        if options.contains(.heic), let heicDictionary = rawValue[kCGImagePropertyHEICSDictionary] as? NSDictionary {
            self.heic = HEIC(rawValue: heicDictionary)
        } else {
            self.heic = nil
        }

        if options.contains(.jfif), let jfifDictionary = rawValue[kCGImagePropertyJFIFDictionary] as? NSDictionary {
            self.jfif = JFIF(rawValue: jfifDictionary)
        } else {
            self.jfif = nil
        }

        if options.contains(.webP), let webPDictionary = rawValue[kCGImagePropertyWebPDictionary] as? NSDictionary {
            self.webP = WebP(rawValue: webPDictionary)
        } else {
            self.webP = nil
        }

        // Defaults that may be updated in other initializers
        self.contentType = nil
        self.imageFile = nil
    }
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
        self = .init(rawValue: properties, options: options)
        
        if let contentType = CGImageSourceGetType(imageSource) as? String {
            self.contentType = UTType(contentType)
        }
    }
    
    public static func getProperties(url: URL) throws(MetadataError) -> [String: Any] {
        guard let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil) else {
            throw MetadataError.invalidImageSource
        }
        
        guard let dict = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as NSDictionary? else {
            throw MetadataError.invalidImageProperties
        }
        
        guard let properties = dict as? [String: Any] else {
            throw MetadataError.invalidImageProperties
        }
        
        return properties
    }
}
