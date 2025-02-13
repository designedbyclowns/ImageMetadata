import Foundation
import ImageIO

extension EXIF {
    /// Indicates the type of scene that was shot.
    ///
    /// It can also be used to record the mode in which the
    /// image was shot.
    ///
    /// > This differs from the ``sceneType`` property.
    public enum SceneCaptureType: Int, Codable {
        /// Standard
        case standard = 0
        /// Landscape
        case landscape
        /// Portrait
        case portrait
        /// Night scene
        case nightScene
    }
}

extension EXIF.SceneCaptureType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .standard:
            String(localized: "Standard")
        case .landscape:
            String(localized: "Landscape")
        case .portrait:
            String(localized: "Portrait")
        case .nightScene:
            String(localized: "Night scene")
        }
    }
}
