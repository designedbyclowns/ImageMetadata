import Foundation
import ImageIO

extension CGImagePropertyOrientation: @retroactive CustomStringConvertible {
    public var description: String {
        switch self {
        case .down:
            String(localized: "down")
        case .up:
            String(localized: "up")
        case .upMirrored:
            String(localized: "upMirrored")
        case .downMirrored:
            String(localized: "downMirrored")
        case .leftMirrored:
            String(localized: "leftMirrored")
        case .right:
            String(localized: "right")
        case .rightMirrored:
            String(localized: "rightMirrored")
        case .left:
            String(localized: "left")
        }
    }
}

extension CGImagePropertyOrientation: @retroactive Codable {}



