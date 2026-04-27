import Foundation

extension JFIF: Encodable {
    enum CodingKeys: String, CodingKey {
        case version
        case xDensity
        case yDensity
        case densityUnit
        case isProgressive
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(version, forKey: .version)
        try container.encodeIfPresent(xDensity, forKey: .xDensity)
        try container.encodeIfPresent(yDensity, forKey: .yDensity)
        try container.encodeIfPresent(densityUnit, forKey: .densityUnit)
        try container.encodeIfPresent(isProgressive, forKey: .isProgressive)
    }
}
