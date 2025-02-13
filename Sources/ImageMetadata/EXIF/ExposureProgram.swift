import Foundation
import ImageIO

extension EXIF {
    /// The class of the program used by the camera to
    /// set exposure when the picture is taken.
    public enum ExposureProgram: Int, Codable {
        /// Not defined
        case notDefined = 0
        /// Manual
        case manual
        /// Normal program
        case normalProgram
        /// Aperture priority
        case aperturePriority
        /// Shutter priority
        case shutterPriority
        /// Creative program
        ///
        /// Biased toward depth of field.
        case creativeProgram
        /// Action program
        ///
        /// Biased toward fast shutter speed.
        case actionProgram
        /// Portrait mode.
        ///
        /// For closeup photos with the background out of focus.
        case portraitMode
        /// Landscape mode
        ///
        /// For landscape photos with the background in focus.
        case landscapeMode
        
        case other
    }
}

extension EXIF.ExposureProgram: CustomStringConvertible {
    public var description: String {
        switch self {
        case .actionProgram:
            String(localized: "Action program")
        case .notDefined:
            String(localized: "Not defined")
        case .manual:
            String(localized: "Manual")
        case .normalProgram:
            String(localized: "Normal program")
        case .aperturePriority:
            String(localized: "Aperture priority")
        case .shutterPriority:
            String(localized: "Shutter priority")
        case .creativeProgram:
            String(localized: "Creative program")
        case .portraitMode:
            String(localized: "Portrait mode")
        case .landscapeMode:
            String(localized: "Landscape mode")
        case .other:
            String(localized: "Other")
        }
    }
}
