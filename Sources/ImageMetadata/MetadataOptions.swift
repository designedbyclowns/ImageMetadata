/// Metadata parsing options.
public struct MetadataOptions: OptionSet, Sendable {
    public init(rawValue: Self.RawValue) {
        self.rawValue = rawValue
    }
    
    public let rawValue: Int

    /// Include EXIF Metadata.
    public static let exif = MetadataOptions(rawValue: 1 << 0)
    /// Include IPTC Metadata.
    public static let iptc = MetadataOptions(rawValue: 1 << 1)
    /// Include TIFF Metadata.
    public static let tiff = MetadataOptions(rawValue: 1 << 2)
    /// Include GPS Metadata.
    public static let gps  = MetadataOptions(rawValue: 1 << 3)
    /// Include DNG Metadata.
    public static let dng  = MetadataOptions(rawValue: 1 << 4)
    /// Include PNG Metadata.
    public static let png  = MetadataOptions(rawValue: 1 << 5)
    /// Include GIF Metadata.
    public static let gif  = MetadataOptions(rawValue: 1 << 6)
    /// Include 8BIM (Photoshop) Metadata.
    public static let eightBIM = MetadataOptions(rawValue: 1 << 7)
    /// Include HEIC Metadata.
    public static let heic = MetadataOptions(rawValue: 1 << 8)
    /// Include JFIF Metadata.
    public static let jfif = MetadataOptions(rawValue: 1 << 9)
    /// Include WebP Metadata.
    public static let webP = MetadataOptions(rawValue: 1 << 10)
    /// Don't include any additional metadata types.
    public static let none: MetadataOptions = []
    /// Include all known metadata types.
    public static let all: MetadataOptions = [.exif, .iptc, .tiff, .gps, .dng, .png, .gif, .eightBIM, .heic, .jfif, .webP]
}
