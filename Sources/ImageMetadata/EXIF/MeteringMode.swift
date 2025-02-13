import Foundation
import ImageIO

extension EXIF {
    /// The metering mode.
    public enum MeteringMode: Int, Codable {
        /// Unknown
        case unknown = 0
        /// Average
        case average
        /// Center weighted average
        case centerWeightedAverage
        /// Spot
        case spot
        /// Multi Spot
        case multiSpot
        /// Pattern
        case pattern
        /// Partial
        case partial
        /// Other
        case other = 255
    }
}

extension EXIF.MeteringMode: CustomStringConvertible {
    public var description: String {
        switch self {
        case .average:
            String(localized: "Average")
        case .unknown:
            String(localized: "Unknown")
        case .centerWeightedAverage:
            String(localized: "Center weighted average")
        case .spot:
            String(localized: "Spot")
        case .multiSpot:
            String(localized: "Multi Spot")
        case .pattern:
            String(localized: "Pattern")
        case .partial:
            String(localized: "Partial")
        case .other:
            String(localized: "Other")
        }
    }
}
