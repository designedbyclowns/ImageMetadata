import Foundation
import ImageIO

extension EXIF {
    /// The white balance mode set when the image was shot.
    public enum WhiteBalance: Int, Codable {
        /// Auto white balance
        case auto = 0
        /// Manual white balance
        case manual
    }
}

extension EXIF.WhiteBalance: CustomStringConvertible {
    public var description: String {
        switch self {
        case .auto:
            String(localized: "Auto white balance")
        case .manual:
            String(localized: "Manual white balance")
        }
    }
}
