import Foundation

extension EXIF {
    /// This tag indicates whether the recorded image is a composite image* or not.
    ///
    /// A composite image means that is generated from multiple taken images (source images).
    public enum CompositeImage: Int, Sendable, Codable {
        /// Unknown
        case unknown = 0
        
        /// Not a composite image.
        case no
        
        /// General composite image.
        ///
        /// A composite image and the generating method is not identified.
        case general
        
        /// Composite image captured when shooting
        ///
        /// A composite image generated only from multiple source images (tentatively recorded images)
        /// those are sequentially captured by the image sensor when shooting (no need for all source images
        /// to be used), and also the picture taking conditions (such as aperture value, subject distance,
        /// light source, lens focal length) and the objective area (field of view) are considered to be
        ///  constant during the capturing of all the source images.
        case captured
    }
}

extension EXIF.CompositeImage: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown:
            String(localized: "unknown")
        case .no:
            String(localized: "no")
        case .general:
            String(localized: "general")
        case .captured:
            String(localized: "captured")
        }
    }
}
