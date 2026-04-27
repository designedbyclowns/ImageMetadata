public import Foundation
import ImageIO

/// Graphics Interchange Format (GIF)
///
/// Keys mirror Apple's [GIF Image Properties](https://developer.apple.com/documentation/imageio/gif-image-properties).
public struct GIF: Metadata {

    // MARK: - Canvas

    /// Width of the logical screen the frames composite onto.
    public let canvasPixelWidth: Int?

    /// Height of the logical screen the frames composite onto.
    public let canvasPixelHeight: Int?

    // MARK: - Animation

    /// The clamped frame delay in seconds. Browsers typically enforce a minimum
    /// (around 0.1s) — see ``unclampedDelayTime`` for the original value.
    public let delayTime: Double?

    /// The original frame delay in seconds, before any browser-side clamping.
    public let unclampedDelayTime: Double?

    /// The number of times the animation should loop. `0` means infinite.
    public let loopCount: Int?

    /// Stringified per-frame metadata dictionaries. The exact keys aren't
    /// publicly documented, so each frame is represented as a single string.
    public let frameInfoArray: [String]?

    // MARK: - Color

    /// Whether the GIF has a global color map (palette).
    public let hasGlobalColorMap: Bool?

    /// The GIF's color map as raw palette bytes.
    public let imageColorMap: Data?

    // MARK: - Initialization

    public init(rawValue: NSDictionary) {
        self.canvasPixelWidth = rawValue[kCGImagePropertyGIFCanvasPixelWidth] as? Int
        self.canvasPixelHeight = rawValue[kCGImagePropertyGIFCanvasPixelHeight] as? Int

        self.delayTime = rawValue[kCGImagePropertyGIFDelayTime] as? Double
        self.unclampedDelayTime = rawValue[kCGImagePropertyGIFUnclampedDelayTime] as? Double
        self.loopCount = rawValue[kCGImagePropertyGIFLoopCount] as? Int

        if let frames = rawValue[kCGImagePropertyGIFFrameInfoArray] as? [Any] {
            self.frameInfoArray = frames.compactMap(Self.describe)
        } else {
            self.frameInfoArray = nil
        }

        self.hasGlobalColorMap = rawValue[kCGImagePropertyGIFHasGlobalColorMap] as? Bool
        self.imageColorMap = rawValue[kCGImagePropertyGIFImageColorMap] as? Data
    }
}
