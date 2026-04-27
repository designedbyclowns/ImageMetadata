import Foundation

extension PNG: Encodable {
    enum CodingKeys: String, CodingKey {
        case author
        case comment
        case copyright
        case imageDescription = "description"
        case disclaimer
        case software
        case source
        case title
        case warning

        case creationTime
        case modificationTime

        case chromaticities
        case gamma
        case sRGBIntent
        case transparency

        case compressionFilter
        case interlaceType

        case pixelsAspectRatio
        case xPixelsPerMeter
        case yPixelsPerMeter
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(author, forKey: .author)
        try container.encodeIfPresent(comment, forKey: .comment)
        try container.encodeIfPresent(copyright, forKey: .copyright)
        try container.encodeIfPresent(imageDescription, forKey: .imageDescription)
        try container.encodeIfPresent(disclaimer, forKey: .disclaimer)
        try container.encodeIfPresent(software, forKey: .software)
        try container.encodeIfPresent(source, forKey: .source)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(warning, forKey: .warning)

        try container.encodeIfPresent(creationTime, forKey: .creationTime)
        try container.encodeIfPresent(modificationTime, forKey: .modificationTime)

        try container.encodeIfPresent(chromaticities, forKey: .chromaticities)
        try container.encodeIfPresent(gamma, forKey: .gamma)
        try container.encodeIfPresent(sRGBIntent, forKey: .sRGBIntent)
        try container.encodeIfPresent(transparency, forKey: .transparency)

        try container.encodeIfPresent(compressionFilter, forKey: .compressionFilter)
        try container.encodeIfPresent(interlaceType, forKey: .interlaceType)

        try container.encodeIfPresent(pixelsAspectRatio, forKey: .pixelsAspectRatio)
        try container.encodeIfPresent(xPixelsPerMeter, forKey: .xPixelsPerMeter)
        try container.encodeIfPresent(yPixelsPerMeter, forKey: .yPixelsPerMeter)
    }
}
