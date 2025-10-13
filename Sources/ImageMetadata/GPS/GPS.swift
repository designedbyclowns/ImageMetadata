public import Foundation
import ImageIO

/// Metadata for an image that has Global Positioning System (GPS) information.
public struct GPS: Metadata {
    /// The altitude.
    public let altitude: Double?

    // The altitude point of reference.
    public let altitudeReference: String?
    
    /// The latitude.
    ///
    /// This value should be interpreted using the `latitudeReference` instead of its sign.
    public let latitude: Double?
    
    /// An indication of whether the latitude is north or south.
    public let latitudeReference: LatitudeReference?
    
    /// The longitude.
    ///
    /// This value should be interpreted using the `longitudeReference` instead of its sign.
    public let longitude: Double?
    
    /// An indication of whether the longitude is east or west.
    public let longitudeReference: LongitudeReference?
    
    /// The horizontal error in the GPS position.
    public let horizontalPositioningError: Double?
    
    /// The date relative to Coordinated Universal Time (UTC).
    public let dateStamp: String?

    /// The time in Coordinated Universal Time (UTC).
    public let timeStamp: String?
    
    /// The date when the location was recorded.
    ///
    /// In Coordinated Universal Time (UTC).
    public let date: Date?
        
    public init(rawValue: NSDictionary) {
        self.altitude = rawValue[kCGImagePropertyGPSAltitude] as? Double
        self.altitudeReference = rawValue[kCGImagePropertyGPSAltitudeRef] as? String
        
        self.latitude = rawValue[kCGImagePropertyGPSLatitude] as? Double
        self.longitude = rawValue[kCGImagePropertyGPSLongitude] as? Double
        
        if let value = rawValue[kCGImagePropertyGPSLatitudeRef] as? String {
            self.latitudeReference = LatitudeReference(rawValue: value)
        } else {
            self.latitudeReference = nil
        }
        
        if let value = rawValue[kCGImagePropertyGPSLongitudeRef] as? String {
            self.longitudeReference = LongitudeReference(rawValue: value)
        } else {
            self.longitudeReference = nil
        }
        
        self.horizontalPositioningError = rawValue[kCGImagePropertyGPSHPositioningError] as? Double
        
        let dateStamp = rawValue[kCGImagePropertyGPSDateStamp] as? String
        let timeStamp = rawValue[kCGImagePropertyGPSTimeStamp] as? String
        
        self.dateStamp = dateStamp
        self.timeStamp = timeStamp
        
        if let dateStamp, let timeStamp {
            let parseStrategy = Date.VerbatimFormatStyle(
                format: "\(year: .defaultDigits):\(month: .twoDigits):\(day: .twoDigits) \(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .oneBased)):\(minute: .twoDigits):\(second: .twoDigits)",
                locale: Locale(identifier: "en_US"),
                timeZone: .gmt,
                calendar: .current
            ).parseStrategy
            
            self.date = try? parseStrategy.parse("\(dateStamp) \(timeStamp)")
        } else {
            self.date = nil
        }
    }
}

extension GPS {
    public enum LatitudeReference: String, CustomStringConvertible, Sendable {
        case north = "N"
        case south = "S"
        
        var sign: FloatingPointSign {
            switch self {
            case .north: return .plus
            case .south: return .minus
            }
        }
        
        public var description: String { rawValue }
    }
    
    public enum LongitudeReference: String, CustomStringConvertible, Sendable  {
        case east = "E"
        case west = "W"
        
        var sign: FloatingPointSign {
            switch self {
            case .east: return .minus
            case .west: return .plus
            }
        }
        
        public var description: String { rawValue }
    }
}

