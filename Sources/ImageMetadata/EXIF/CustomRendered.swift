import Foundation
import ImageIO

extension EXIF {
    /// Indicates the use of special processing on image data, such as rendering geared to output.
    ///
    /// When ``custom`` processing is performed, the reader is expected to disable or minimize any further processing.
    public enum CustomRendered: Int, Codable{
        /// Normal process
        case normal = 0
        /// Custom process
        ///
        /// > The reader is expected to disable or minimize any further processing.
        case custom
    }
}

extension EXIF.CustomRendered: CustomStringConvertible {
    public var description: String {
        switch self {
        case .normal:
            String(localized: "Normal process")
        case .custom:
            String(localized: "Custom process")
        }
    }
}
