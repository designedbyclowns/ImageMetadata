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
    /// Don't include any additional metadata types.
    public static let none: MetadataOptions = []
    /// Include all known metadata types.
    public static let all: MetadataOptions = [.exif, .iptc, .tiff, .gps]
}
