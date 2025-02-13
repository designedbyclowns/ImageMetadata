import ImageIO

public enum ImageOrientation: UInt32, Sendable, Codable {
    /// The encoded image data matches the image’s intended display orientation.
    case up = 1
    /// The encoded image data is horizontally flipped from the image’s intended display orientation.
    case upMirrored = 2
    /// The encoded image data is rotated 180° from the image’s intended display orientation.
    case down = 3
    /// The encoded image data is vertically flipped from the image’s intended display orientation.
    case downMirrored = 4
    /// The encoded image data is rotated 90° clockwise from the image’s intended display orientation.
    case left = 8
    /// The encoded image data is horizontally flipped and rotated 90° counter-clockwise from the image’s intended display orientation.
    case leftMirrored = 5
    /// The encoded image data is rotated 90° clockwise from the image’s intended display orientation.
    case right = 6
    /// The encoded image data is horizontally flipped and rotated 90° clockwise from the image’s intended display orientation.
    case rightMirrored = 7
}

public extension ImageOrientation {
    init?(cgOrientation: CGImagePropertyOrientation) {
        self.init(rawValue:cgOrientation.rawValue)
    }
    
    var cgOrientation: CGImagePropertyOrientation? {
        CGImagePropertyOrientation(rawValue: self.rawValue)
    }
}

extension ImageOrientation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .up:
            String(localized: "up")
        case .upMirrored:
            String(localized: "upMirrored")
        case .down:
            String(localized: "down")
        case .downMirrored:
            String(localized: "downMirrored")
        case .left:
            String(localized: "left")
        case .leftMirrored:
            String(localized: "leftMirrored")
        case .right:
            String(localized: "right")
        case .rightMirrored:
            String(localized: "rightMirrored")
        }
    }
}
