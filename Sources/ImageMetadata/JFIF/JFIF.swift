public import Foundation
import ImageIO

/// JPEG File Interchange Format (JFIF).
///
/// Keys mirror Apple's [JFIF Image Properties](https://developer.apple.com/documentation/imageio/jfif-image-properties).
/// JFIF is one of two common container formats around JPEG-encoded image data
/// (the other being EXIF); modern camera JPEGs use EXIF, but JFIF segments
/// are still emitted by many encoders.
public struct JFIF: Metadata {

    /// The JFIF version (e.g. `"1.2"`).
    public let version: String?

    /// The horizontal pixel density.
    public let xDensity: Double?

    /// The vertical pixel density.
    public let yDensity: Double?

    /// Units for ``xDensity`` and ``yDensity``: `0` = aspect ratio only,
    /// `1` = dots per inch, `2` = dots per centimeter.
    public let densityUnit: Int?

    /// `true` when the JPEG was encoded with progressive scans.
    public let isProgressive: Bool?

    // MARK: - Initialization

    public init(rawValue: NSDictionary) {
        self.version = Self.versionString(rawValue[kCGImagePropertyJFIFVersion])
        self.xDensity = rawValue[kCGImagePropertyJFIFXDensity] as? Double
        self.yDensity = rawValue[kCGImagePropertyJFIFYDensity] as? Double
        self.densityUnit = rawValue[kCGImagePropertyJFIFDensityUnit] as? Int
        self.isProgressive = rawValue[kCGImagePropertyJFIFIsProgressive] as? Bool
    }
}
