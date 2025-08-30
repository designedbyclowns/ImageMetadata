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
