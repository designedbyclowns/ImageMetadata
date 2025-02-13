import Foundation
import ImageIO

/// Metadata for an image that has Global Positioning System (GPS) information.
public struct GPS: Metadata {
    public typealias RawValue = NSDictionary
    
    public init(rawValue: NSDictionary) {
        self.rawValue = rawValue
    }
    
    public let rawValue: NSDictionary
    
    /// The altitude.
    public var altitude: Double? {
        rawValue[kCGImagePropertyGPSAltitude] as? Double
    }
    
    // The altitude point of reference.
    public var altitudeReference: String? {
        rawValue[kCGImagePropertyGPSAltitudeRef] as? String
    }
    
    /// The latitude.
    public var latitude: Double? {
        rawValue[kCGImagePropertyGPSLatitude] as? Double
    }
    
    /// An indication of whether the latitude is north or south.
    public var latitudeReference: String? {
        rawValue[kCGImagePropertyGPSLatitudeRef] as? String
    }
    
    /// The longitude.
    public var longitude: Double? {
        rawValue[kCGImagePropertyGPSLongitude] as? Double
    }
    
    /// An indication of whether the longitude is east or west.
    public var longitudeReference: String? {
        rawValue[kCGImagePropertyGPSLongitudeRef] as? String
    }
    
    /// The horizontal error in the GPS position.
    public var horizontalPositioningError: Double? {
        rawValue[kCGImagePropertyGPSHPositioningError] as? Double
    }
    
    /// The date relative to Coordinated Universal Time (UTC).
    public var dateStamp: String? {
        rawValue[kCGImagePropertyGPSDateStamp] as? String
    }
    
    /// The time in UTC (Coordinated Universal Time).
    public var timeStamp: String? {
        rawValue[kCGImagePropertyGPSTimeStamp] as? String
    }
    
    /// The date when the location was recorded.
    public var date: Date? {
        guard let dateStamp, let timeStamp else { return nil }
        return Self.dateFormatter.date(from: "\(dateStamp) \(timeStamp)")
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return formatter
    }()
}

extension GPS: Encodable {
    enum CodingKeys: String, CodingKey {
        case altitude
        case altitudeReference
        case latitude
        case latitudeReference
        case longitude
        case longitudeReference
        case horizontalPositioningError
        case dateTime
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(altitude, forKey: .altitude)
        try container.encodeIfPresent(altitudeReference, forKey: .altitudeReference)
        try container.encodeIfPresent(latitude, forKey: .latitude)
        try container.encodeIfPresent(latitudeReference, forKey: .latitudeReference)
        try container.encodeIfPresent(longitude, forKey: .longitude)
        try container.encodeIfPresent(longitudeReference, forKey: .longitudeReference)
        try container.encodeIfPresent(horizontalPositioningError, forKey: .horizontalPositioningError)
        try container.encodeIfPresent(date, forKey: .dateTime)
    }
}

extension GPS: CustomStringConvertible {
    public var description: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        encoder.dateEncodingStrategy = .iso8601
        
        guard let json = try? encoder.encode(self) else { return "" }
        return String(decoding: json, as: UTF8.self)
    }
}

extension GPS: CustomDebugStringConvertible {
    public var debugDescription: String {
        String(describing: rawValue)
    }
}
