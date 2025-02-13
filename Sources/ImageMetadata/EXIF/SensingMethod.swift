import Foundation
import ImageIO

extension EXIF {
    /// Indicates the image sensor type on the camera or input device.
    public enum SensingMethod: Int, Codable {
        /// Not defined
        case notDefined = 1
        /// One-chip color area sensor
        case oneChipColorArea = 2
        /// Two-chip color area sensor
        case twoChipColorArea = 3
        /// Three-chip color area sensor
        case threeChipColorArea = 4
        /// Color sequential area sensor
        case colorSequentialArea = 5
        /// Trilinear sensor
        case trilinear = 7
        /// Color sequential linear sensor
        case colorSequentialLinear = 8
    }
}

extension EXIF.SensingMethod: CustomStringConvertible {
    public var description: String {
        switch self {
        case .notDefined:
            String(localized: "Not defined")
        case .oneChipColorArea:
            String(localized: "One-chip color area sensor")
        case .twoChipColorArea:
            String(localized: "Two-chip color area sensor")
        case .threeChipColorArea:
            String(localized: "Three-chip color area sensor")
        case .colorSequentialArea:
            String(localized: "Color sequential area sensor")
        case .trilinear:
            String(localized: "Trilinear sensor")
        case .colorSequentialLinear:
            String(localized: "Color sequential linear sensor")
        }
    }
}
