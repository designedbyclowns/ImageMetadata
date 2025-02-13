/// Metadata parsing options.
public struct MetadataOptions: OptionSet, Sendable {
    public init(rawValue: Self.RawValue) {
        self.rawValue = rawValue
    }
    
    public let rawValue: Int

    public static let exif = MetadataOptions(rawValue: 1 << 0)
    public static let iptc = MetadataOptions(rawValue: 1 << 1)
    public static let tiff = MetadataOptions(rawValue: 1 << 2)
    public static let gps  = MetadataOptions(rawValue: 1 << 3)
    
    public static let none: MetadataOptions = []
    public static let all: MetadataOptions = [.exif, .iptc, .tiff, .gps]
}
