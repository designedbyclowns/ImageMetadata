import Foundation
import ImageIO

extension EXIF {
    /// Indicates the contrast processing applied by the camera
    /// when the image was shot.
    public enum Contrast: Int, Codable {
        /// Normal
        case normal = 0
        /// Soft
        case soft
        /// Hard
        case hard
    }
}

extension EXIF.Contrast: CustomStringConvertible {
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
