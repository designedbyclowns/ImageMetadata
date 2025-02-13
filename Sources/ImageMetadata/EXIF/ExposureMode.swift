import Foundation
import ImageIO

extension EXIF {
    /// The exposure mode set when the image was shot.
    public enum ExposureMode: Int, Codable {
        /// Auto exposure
        case auto = 0
        /// Manual exposure
        case manual
        /// Auto bracket
        ///
        /// In auto-bracketing mode, the camera shoots a series of
        /// frames of the same scene at different exposure settings.
        case autoBracket
    }
}

extension EXIF.ExposureMode: CustomStringConvertible {
    public var description: String {
        switch self {
        case .auto:
            String(localized: "Auto exposure")
        case .autoBracket:
            String(localized: "Auto bracket")
        case .manual:
            String(localized: "Manual exposure")
        }
    }
}
