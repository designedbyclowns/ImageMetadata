public import Foundation
import ImageIO

/// Tag Image File Format
///
/// A tag-based file format for storing and interchanging raster images.
/// https://www.loc.gov/preservation/digital/formats/fdd/fdd000022.shtml
public struct TIFF: Metadata {
    
    /// The artist who created the image.
    public let artist: String?

    /// Copyright information.
    public let copyright: String?

    /// The date and time that the image was created.
    public let dateTime: Date?

    /// The document name.
    public let documentName: String?

    /// The computer or operating system used when the image was created.
    public let hostComputer: String?

    /// The image description.
    public let imageDescription: String?

    /// The name of the manufacturer of the camera or input device.
    public let make: String?

    /// The camera or input device model.
    public let model: String?

    /// The image orientation.
    public let orientation: Int?

    /// The chromaticities of the primaries of the image.
    public let primaryChromaticities: String?

    /// The units of resolution.
    public let resolutionUnit: Int?

    /// The color space of the image data.
    public let photometricInterpretation: Int?

    /// The name and version of the software used for image creation.
    public let software: String?

    /// The tile length.
    public let tileLength: String?

    /// The tile width.
    public let tileWidth: String?

    /// The transfer function, in tabular format, used to map pixel components
    /// from a nonlinear form into a linear form.
    public let transferFunction: String?

    /// The number of pixels per resolution unit in the image width direction.
    public let xResolution: Double?

    /// The number of pixels per resolution unit in the image height direction.
    public let yResolution: Double?

    /// The compression scheme used on the image data.
    public let compression: Int?

    /// The white point of the image.
    public let whitePoint: Int?
    
    // MARK: - Initialization
    
    public init(rawValue: NSDictionary) {
        self.artist = rawValue[kCGImagePropertyTIFFArtist] as? String
        self.compression = rawValue[kCGImagePropertyTIFFCompression] as? Int
        self.copyright = rawValue[kCGImagePropertyTIFFCopyright] as? String
        self.documentName = rawValue[kCGImagePropertyTIFFDocumentName] as? String
        self.hostComputer = rawValue[kCGImagePropertyTIFFHostComputer] as? String
        self.imageDescription = rawValue[kCGImagePropertyTIFFImageDescription] as? String
        self.make = rawValue[kCGImagePropertyTIFFMake] as? String
        self.model = rawValue[kCGImagePropertyTIFFModel] as? String
        self.orientation = rawValue[kCGImagePropertyTIFFOrientation] as? Int
        self.photometricInterpretation = rawValue[kCGImagePropertyTIFFPhotometricInterpretation] as? Int
        self.primaryChromaticities = rawValue[kCGImagePropertyTIFFPrimaryChromaticities] as? String
        self.resolutionUnit = rawValue[kCGImagePropertyTIFFResolutionUnit] as? Int
        self.software = rawValue[kCGImagePropertyTIFFSoftware] as? String
        self.tileLength = rawValue[kCGImagePropertyTIFFTileLength] as? String
        self.tileWidth = rawValue[kCGImagePropertyTIFFTileWidth] as? String
        self.transferFunction = rawValue[kCGImagePropertyTIFFTransferFunction] as? String
        self.whitePoint = rawValue[kCGImagePropertyTIFFWhitePoint] as? Int
        self.xResolution = rawValue[kCGImagePropertyTIFFXResolution] as? Double
        self.yResolution = rawValue[kCGImagePropertyTIFFYResolution] as? Double
        
        // Handle date parsing
        if let dateTimeString = rawValue[kCGImagePropertyTIFFDateTime] as? String {
            let parseStrategy = Date.VerbatimFormatStyle(
                format: "\(year: .defaultDigits):\(month: .twoDigits):\(day: .twoDigits) \(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .oneBased)):\(minute: .twoDigits):\(second: .twoDigits)",
                locale: Locale(identifier: "en_US"),
                // TIFF date format provides no offset or time zone info so assume local.
                timeZone: .current,
                calendar: .gregorian
            ).parseStrategy
            
            self.dateTime = try? parseStrategy.parse(dateTimeString)
        } else {
            self.dateTime = nil
        }
    }
}

