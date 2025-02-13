import Foundation
import ImageIO

extension EXIF {
    /// Indicates the distance to the subject.
    public enum SubjectDistanceRange: Int, Codable {
        /// Unknown
        case unknown = 0
        /// Macro
        case macro
        /// Close view
        case closeView
        /// Distant view
        case distantView
        /// Other
        case other
    }
}

extension EXIF.SubjectDistanceRange: CustomStringConvertible {
    public var description: String {
        switch self {
        case .closeView:
            String(localized: "Close view")
        case .unknown:
            String(localized: "Unknown")
        case .macro:
            String(localized: "Macro")
        case .distantView:
            String(localized: "Distant view")
        case .other:
            String(localized: "Other")
        }
    }
}
