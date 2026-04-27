public import Foundation
import ImageIO

/// WebP image format metadata.
///
/// Keys mirror Apple's [WebP Image Properties](https://developer.apple.com/documentation/imageio/webp-image-properties).
/// The keys are animation-focused, so for static WebP files the dictionary
/// will typically be missing or all-nil.
public struct WebP: Metadata {

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
        self.canvasPixelWidth = rawValue[kCGImagePropertyWebPCanvasPixelWidth] as? Int
        self.canvasPixelHeight = rawValue[kCGImagePropertyWebPCanvasPixelHeight] as? Int

        self.delayTime = rawValue[kCGImagePropertyWebPDelayTime] as? Double
        self.unclampedDelayTime = rawValue[kCGImagePropertyWebPUnclampedDelayTime] as? Double
        self.loopCount = rawValue[kCGImagePropertyWebPLoopCount] as? Int

        if let frames = rawValue[kCGImagePropertyWebPFrameInfoArray] as? [Any] {
            self.frameInfoArray = frames.compactMap(Self.describe)
        } else {
            self.frameInfoArray = nil
        }
    }
}
