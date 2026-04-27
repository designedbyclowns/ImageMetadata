public import Foundation
import ImageIO

/// High Efficiency Image Coding (HEIC).
///
/// Keys mirror Apple's [HEIC Image Properties](https://developer.apple.com/documentation/imageio/heic-image-properties).
/// Despite the docs page name, the underlying ImageIO constants are namespaced
/// `HEICS` (HEIC Sequence) and primarily describe animated HEIC content.
public struct HEIC: Metadata {

    // MARK: - Canvas

    /// Width of the logical canvas the frames composite onto.
    public let canvasPixelWidth: Int?

    /// Height of the logical canvas the frames composite onto.
    public let canvasPixelHeight: Int?

    // MARK: - Animation

    /// The clamped frame delay in seconds. See ``unclampedDelayTime`` for the
    /// original value before any browser-side clamping.
    public let delayTime: Double?

    /// The original frame delay in seconds, before any browser-side clamping.
    public let unclampedDelayTime: Double?

    /// The number of times the animation should loop. `0` means infinite.
    public let loopCount: Int?

    /// Stringified per-frame metadata dictionaries. The exact keys aren't
    /// publicly documented, so each frame is represented as a single string.
    public let frameInfoArray: [String]?

    // MARK: - Initialization

    public init(rawValue: NSDictionary) {
        self.canvasPixelWidth = rawValue[kCGImagePropertyHEICSCanvasPixelWidth] as? Int
        self.canvasPixelHeight = rawValue[kCGImagePropertyHEICSCanvasPixelHeight] as? Int

        self.delayTime = rawValue[kCGImagePropertyHEICSDelayTime] as? Double
        self.unclampedDelayTime = rawValue[kCGImagePropertyHEICSUnclampedDelayTime] as? Double
        self.loopCount = rawValue[kCGImagePropertyHEICSLoopCount] as? Int

        if let frames = rawValue[kCGImagePropertyHEICSFrameInfoArray] as? [Any] {
            self.frameInfoArray = frames.compactMap(Self.describe)
        } else {
            self.frameInfoArray = nil
        }
    }
}
