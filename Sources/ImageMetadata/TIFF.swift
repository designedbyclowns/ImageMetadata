import Foundation
import ImageIO

public struct TIFF: RawRepresentable {
    
    // MARK: - Image Quality
    
    /// The compression scheme used on the image data.
    public var compression: Int? {
        rawValue[kCGImagePropertyTIFFCompression] as? Int
    }
    
    /// The color space of the image data.
    public var photometricInterpretation: Int? {
        rawValue[kCGImagePropertyTIFFPhotometricInterpretation] as? Int
    }
    
    /// The transfer function, in tabular format, used to map pixel components
    /// from a nonlinear form into a linear form.
    public var transferFunction: String? {
        rawValue[kCGImagePropertyTIFFTransferFunction] as? String
    }
    
    // MARK: - Canvas Details
    
    /// The image orientation.
    public var orientation: Int? {
        rawValue[kCGImagePropertyTIFFOrientation] as? Int
    }
    
    /// The number of pixels per resolution unit in the image width direction.
    public var xResolution: Double? {
        rawValue[kCGImagePropertyTIFFXResolution] as? Double
    }
    
    /// The number of pixels per resolution unit in the image height direction.
    public var yResolution: Double? {
        rawValue[kCGImagePropertyTIFFYResolution] as? Double
    }
    
    /// The units of resolution.
    public var resolutionUnit: Int? {
        rawValue[kCGImagePropertyTIFFResolutionUnit] as? Int
    }
    
    /// The white point of the image.
    public var whitePoint: Int? {
        rawValue[kCGImagePropertyTIFFWhitePoint] as? Int
    }
    
    /// The chromaticities of the primaries of the image.
    public var primaryChromaticities: String? {
        rawValue[kCGImagePropertyTIFFPrimaryChromaticities] as? String
    }
    public var tileLength: String? {
        rawValue[kCGImagePropertyTIFFTileLength] as? String
    }
    
    public var tileWidth: String? {
        rawValue[kCGImagePropertyTIFFTileWidth] as? String
    }
    // MARK: - Descriptive Information
    
    /// The document name.
    public var documentName: String? {
        rawValue[kCGImagePropertyTIFFDocumentName] as? String
    }
    
    /// The image description.
    public var imageDescription: String? {
        rawValue[kCGImagePropertyTIFFImageDescription] as? String
    }
    
    /// The artist who created the image.
    public var artist: String? {
        rawValue[kCGImagePropertyTIFFArtist] as? String
    }
    
    /// Copyright information.
    public var copyright: String? {
        rawValue[kCGImagePropertyTIFFCopyright] as? String
    }
    
    /// The date and time that the image was created.
    public var dateTime: Date? {
        guard let dateTimeString = rawValue[kCGImagePropertyTIFFDateTime] as? String else { return nil }
        return Self.dateFormatter.date(from: dateTimeString)

    }
    
    /// The name of the manufacturer of the camera or input device.
    public var make: String? {
        rawValue[kCGImagePropertyTIFFMake] as? String
    }
    
    /// The camera or input device model.
    public var model: String? {
        rawValue[kCGImagePropertyTIFFModel] as? String
    }
    
    /// The name and version of the software used for image creation.
    public var software: String? {
        rawValue[kCGImagePropertyTIFFSoftware] as? String
    }
    
    /// The computer or operating system used when the image was created.
    public var hostComputer: String? {
        rawValue[kCGImagePropertyTIFFHostComputer] as? String
    }
    
    // MARK: - RawRepresentable
    
    public typealias RawValue = NSDictionary
    
    public init(rawValue: NSDictionary) {
        self.rawValue = rawValue
    }
    
    public let rawValue: NSDictionary
    
    // MARK: - Formatters
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return formatter
    }()
}

extension TIFF: Encodable {
    enum CodingKeys: String, CodingKey {
        case artist
        case compression
        case copyright
        case dateTime
        case documentName
        case hostComputer
        case imageDescription
        case make
        case model
        case orientation
        case photometricInterpretation
        case primaryChromaticities
        case resolutionUnit
        case software
        case tileLength
        case tileWidth
        case transferFunction
        case whitePoint
        case xResolution
        case yResolution
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(artist, forKey: .artist)
        try container.encodeIfPresent(compression, forKey: .compression)
        try container.encodeIfPresent(copyright, forKey: .copyright)
        try container.encodeIfPresent(dateTime, forKey: .dateTime)
        try container.encodeIfPresent(documentName, forKey: .documentName)
        try container.encodeIfPresent(hostComputer, forKey: .hostComputer)
        try container.encodeIfPresent(imageDescription, forKey: .imageDescription)
        try container.encodeIfPresent(make, forKey: .make)
        try container.encodeIfPresent(model, forKey: .model)
        try container.encodeIfPresent(orientation, forKey: .orientation)
        try container.encodeIfPresent(photometricInterpretation, forKey: .photometricInterpretation)
        try container.encodeIfPresent(primaryChromaticities, forKey: .primaryChromaticities)
        try container.encodeIfPresent(resolutionUnit, forKey: .resolutionUnit)
        try container.encodeIfPresent(software, forKey: .software)
        try container.encodeIfPresent(tileLength, forKey: .tileLength)
        try container.encodeIfPresent(tileWidth, forKey: .tileWidth)
        try container.encodeIfPresent(transferFunction, forKey: .transferFunction)
        try container.encodeIfPresent(whitePoint, forKey: .whitePoint)
        try container.encodeIfPresent(xResolution, forKey: .xResolution)
        try container.encodeIfPresent(yResolution, forKey: .yResolution)
    }
}
