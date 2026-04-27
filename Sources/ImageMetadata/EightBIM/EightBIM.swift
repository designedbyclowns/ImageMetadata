public import Foundation
import ImageIO

/// 8BIM (a.k.a. Photoshop image resource block) metadata.
///
/// Keys mirror Apple's [8BIM Image Properties](https://developer.apple.com/documentation/imageio/8bim-image-properties).
/// 8BIM blocks aren't unique to PSD files — they're frequently embedded in
/// JPEGs and TIFFs that Photoshop has touched.
public struct EightBIM: Metadata {

    /// Names of the layers in the image.
    public let layerNames: [String]?

    /// The 8BIM resource format version.
    public let version: Int?

    // MARK: - Initialization

    public init(rawValue: NSDictionary) {
        self.layerNames = rawValue[kCGImageProperty8BIMLayerNames] as? [String]
        self.version = rawValue[kCGImageProperty8BIMVersion] as? Int
    }
}
