import Foundation

extension EightBIM: Encodable {
    enum CodingKeys: String, CodingKey {
        case layerNames
        case version
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(layerNames, forKey: .layerNames)
        try container.encodeIfPresent(version, forKey: .version)
    }
}
