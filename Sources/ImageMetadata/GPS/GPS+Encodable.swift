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
        try container.encodeIfPresent(latitudeReference?.description, forKey: .latitudeReference)
        try container.encodeIfPresent(longitude, forKey: .longitude)
        try container.encodeIfPresent(longitudeReference?.description, forKey: .longitudeReference)
        try container.encodeIfPresent(horizontalPositioningError, forKey: .horizontalPositioningError)
        try container.encodeIfPresent(date, forKey: .dateTime)
    }
}
