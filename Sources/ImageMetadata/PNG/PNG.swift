public import Foundation
import ImageIO

/// Portable Network Graphics (PNG)
///
/// Keys mirror Apple's [PNG Image Properties](https://developer.apple.com/documentation/imageio/png-image-properties).
public struct PNG: Metadata {

    // MARK: - Text-chunk metadata

    /// The image's author.
    public let author: String?

    /// A free-form comment.
    public let comment: String?

    /// Copyright information.
    public let copyright: String?

    /// A description of the image.
    public let imageDescription: String?

    /// A legal disclaimer.
    public let disclaimer: String?

    /// The name and version of the software used to create the image.
    public let software: String?

    /// The original source of the image (e.g. scanner, camera).
    public let source: String?

    /// The image title.
    public let title: String?

    /// A warning about the image's content.
    public let warning: String?

    // MARK: - Timestamps

    /// The time the image was originally created.
    public let creationTime: Date?

    /// The time the image was last modified.
    public let modificationTime: Date?

    // MARK: - Color & display

    /// CIE chromaticity coordinates of the white point and primaries:
    /// `[whiteX, whiteY, redX, redY, greenX, greenY, blueX, blueY]`.
    public let chromaticities: [Double]?

    /// The image's gamma value.
    public let gamma: Double?

    /// The rendering intent for the embedded sRGB profile.
    public let sRGBIntent: Int?

    /// Per-channel transparency information from the `tRNS` chunk.
    /// Interpretation depends on the PNG color type.
    public let transparency: [Int]?

    // MARK: - Encoding

    /// The compression filter used.
    public let compressionFilter: Int?

    /// The interlace type. `0` = none, `1` = Adam7.
    public let interlaceType: Int?

    // MARK: - Physical size

    /// Aspect ratio of pixels in the image.
    public let pixelsAspectRatio: Double?

    /// Number of pixels per meter along the x-axis.
    public let xPixelsPerMeter: Int?

    /// Number of pixels per meter along the y-axis.
    public let yPixelsPerMeter: Int?

    // MARK: - Initialization

    public init(rawValue: NSDictionary) {
        self.author = rawValue[kCGImagePropertyPNGAuthor] as? String
        self.comment = rawValue[kCGImagePropertyPNGComment] as? String
        self.copyright = rawValue[kCGImagePropertyPNGCopyright] as? String
        self.imageDescription = rawValue[kCGImagePropertyPNGDescription] as? String
        self.disclaimer = rawValue[kCGImagePropertyPNGDisclaimer] as? String
        self.software = rawValue[kCGImagePropertyPNGSoftware] as? String
        self.source = rawValue[kCGImagePropertyPNGSource] as? String
        self.title = rawValue[kCGImagePropertyPNGTitle] as? String
        self.warning = rawValue[kCGImagePropertyPNGWarning] as? String

        self.creationTime = Self.parseDate(rawValue[kCGImagePropertyPNGCreationTime])
        self.modificationTime = Self.parseDate(rawValue[kCGImagePropertyPNGModificationTime])

        self.chromaticities = Self.doubleArray(rawValue[kCGImagePropertyPNGChromaticities])
        self.gamma = rawValue[kCGImagePropertyPNGGamma] as? Double
        self.sRGBIntent = rawValue[kCGImagePropertyPNGsRGBIntent] as? Int
        self.transparency = Self.intArray(rawValue[kCGImagePropertyPNGTransparency])

        self.compressionFilter = rawValue[kCGImagePropertyPNGCompressionFilter] as? Int
        self.interlaceType = rawValue[kCGImagePropertyPNGInterlaceType] as? Int

        self.pixelsAspectRatio = rawValue[kCGImagePropertyPNGPixelsAspectRatio] as? Double
        self.xPixelsPerMeter = rawValue[kCGImagePropertyPNGXPixelsPerMeter] as? Int
        self.yPixelsPerMeter = rawValue[kCGImagePropertyPNGYPixelsPerMeter] as? Int
    }

    // MARK: - Helpers

    /// PNG date strings are inconsistent in the wild. The PNG spec recommends
    /// RFC 1123 format (e.g. "Mon, 17 Jan 2000 07:34:51 GMT"); ISO 8601 is also
    /// common. Try both before giving up.
    private static func parseDate(_ value: Any?) -> Date? {
        guard let string = value as? String else { return nil }

        if let iso = try? Date.ISO8601FormatStyle().parse(string) {
            return iso
        }

        let rfc1123 = DateFormatter()
        rfc1123.locale = Locale(identifier: "en_US_POSIX")
        rfc1123.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        if let date = rfc1123.date(from: string) {
            return date
        }

        return nil
    }
}
