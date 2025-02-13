import Foundation
import ImageIO

extension EXIF {
    /// Indicates the saturation processing applied by the camera
    /// when the image was shot.
    public enum Saturation: Int, Codable {
        /// Normal
        case normal = 0
        /// Low saturation
        case low
        /// High saturation
        case high
    }
}

extension EXIF.Saturation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .normal:
            String(localized: "Normal")
        case .low:
            String(localized: "Low saturation")
        case .high:
            String(localized: "High saturation")
        }
    }
}
