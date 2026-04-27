import Foundation

extension GIF: Encodable {
    enum CodingKeys: String, CodingKey {
        case canvasPixelWidth
        case canvasPixelHeight

        case delayTime
        case unclampedDelayTime
        case loopCount
        case frameInfoArray

        case hasGlobalColorMap
        case imageColorMap
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(canvasPixelWidth, forKey: .canvasPixelWidth)
        try container.encodeIfPresent(canvasPixelHeight, forKey: .canvasPixelHeight)

        try container.encodeIfPresent(delayTime, forKey: .delayTime)
        try container.encodeIfPresent(unclampedDelayTime, forKey: .unclampedDelayTime)
        try container.encodeIfPresent(loopCount, forKey: .loopCount)
        try container.encodeIfPresent(frameInfoArray, forKey: .frameInfoArray)

        try container.encodeIfPresent(hasGlobalColorMap, forKey: .hasGlobalColorMap)
        try container.encodeIfPresent(imageColorMap?.count, forKey: .imageColorMap)
    }
}
