import Foundation
import ImageIO

extension EXIF {
    /// Indicates the type of scene that was shot.
    ///
    /// It can also be used to record the mode in which the
    /// image was shot.
    ///
    /// > This differs from the ``sceneType`` property.
    public enum SceneCaptureType: Int, Sendable, Codable {
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
            String(localized: "standard")
        case .landscape:
            String(localized: "landscape")
        case .portrait:
            String(localized: "portrait")
        case .nightScene:
            String(localized: "night-scene")
        }
    }
}
