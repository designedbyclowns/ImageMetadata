import Foundation

extension EXIF {
    /// The color space information tag (ColorSpace) is always recorded as the color space specifier.
    ///
    /// Normally `sRGB` is used to define the color space based on the PC monitor conditions and environment.
    /// If a color space other than `sRGB` is used, `uncalibrated` is set.
    public enum ColorSpace: Int, Sendable, Codable {
        /// The color space based on the PC monitor conditions and environment.
        case sRGB = 1
        /// A color space other than sRGB is used.
        case uncalibrated = 65535

    }
}

extension EXIF.ColorSpace: CustomStringConvertible {
    public var description: String {
        switch self {
        case .sRGB:
            String(localized: "sRGB")
        case .uncalibrated:
            String(localized: "Uncalibrated")
        }
    }
}
