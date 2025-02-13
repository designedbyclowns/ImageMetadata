import Foundation
import ImageIO

extension EXIF {
    /// Indicates the sharpness processing applied by the camera
    /// when the image was shot.
    public enum Sharpness: Int, Codable {
        /// Normal
        case normal = 0
        /// Soft
        case soft
        /// Hard
        case hard
    }
}

extension EXIF.Sharpness: CustomStringConvertible {
    public var description: String {
        switch self {
        case .normal:
            String(localized: "Normal")
        case .soft:
            String(localized: "Soft")
        case .hard:
            String(localized: "Hard")
        }
    }
}
