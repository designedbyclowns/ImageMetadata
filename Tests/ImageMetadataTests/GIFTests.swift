import Testing
import Foundation
import ImageIO
@testable import ImageMetadata


struct GIFTests {
    static func sampleRawGIF() -> NSDictionary {
        return [
            kCGImagePropertyGIFCanvasPixelWidth: 480,
            kCGImagePropertyGIFCanvasPixelHeight: 320,
            kCGImagePropertyGIFDelayTime: 0.1,
            kCGImagePropertyGIFUnclampedDelayTime: 0.04,
            kCGImagePropertyGIFLoopCount: 0,
            kCGImagePropertyGIFFrameInfoArray: [
                ["delay": 0.1] as NSDictionary,
                ["delay": 0.1] as NSDictionary,
                ["delay": 0.2] as NSDictionary,
            ],
            kCGImagePropertyGIFHasGlobalColorMap: true,
            kCGImagePropertyGIFImageColorMap: Data(repeating: 0xAA, count: 768),
        ]
    }

    let gif: GIF

    init() {
        self.gif = GIF(rawValue: Self.sampleRawGIF())
    }

    // MARK: - Canvas

    @Test func canvasPixelWidth() {
        #expect(gif.canvasPixelWidth == 480)
    }

    @Test func canvasPixelHeight() {
        #expect(gif.canvasPixelHeight == 320)
    }

    // MARK: - Animation

    @Test func delayTime() {
        #expect(gif.delayTime == 0.1)
    }

    @Test func unclampedDelayTime() {
        #expect(gif.unclampedDelayTime == 0.04)
    }

    @Test func loopCount() {
        #expect(gif.loopCount == 0)
    }

    @Test func frameInfoArray() {
        #expect(gif.frameInfoArray?.count == 3)
    }

    // MARK: - Color

    @Test func hasGlobalColorMap() {
        #expect(gif.hasGlobalColorMap == true)
    }

    @Test func imageColorMap() {
        #expect(gif.imageColorMap?.count == 768)
    }

    // MARK: - Encoding

    @Test("Encoding emits present fields and uses byte count for color map")
    func encoding() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(gif)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

        #expect(json["canvasPixelWidth"] as? Int == 480)
        #expect(json["canvasPixelHeight"] as? Int == 320)
        #expect(json["delayTime"] as? Double == 0.1)
        #expect(json["unclampedDelayTime"] as? Double == 0.04)
        #expect(json["loopCount"] as? Int == 0)
        #expect(json["hasGlobalColorMap"] as? Bool == true)
        // Replaced with byte count.
        #expect(json["imageColorMap"] as? Int == 768)
        // Stringified frame entries.
        let frames = try #require(json["frameInfoArray"] as? [String])
        #expect(frames.count == 3)
    }

    @Test("Missing or malformed values produce nils")
    func missingOrMalformedValues() throws {
        let raw = try #require(Self.sampleRawGIF().mutableCopy() as? NSMutableDictionary)
        raw[kCGImagePropertyGIFDelayTime] = "not-a-double"
        raw[kCGImagePropertyGIFLoopCount] = NSNull()
        raw.removeObject(forKey: kCGImagePropertyGIFCanvasPixelWidth)
        raw.removeObject(forKey: kCGImagePropertyGIFFrameInfoArray)

        let gif = GIF(rawValue: raw)

        #expect(gif.delayTime == nil)
        #expect(gif.loopCount == nil)
        #expect(gif.canvasPixelWidth == nil)
        #expect(gif.frameInfoArray == nil)
    }

    @Test("Empty dictionary produces an all-nil GIF that encodes to {}")
    func emptyDictionary() throws {
        let gif = GIF(rawValue: [:])

        #expect(gif.canvasPixelWidth == nil)
        #expect(gif.delayTime == nil)
        #expect(gif.frameInfoArray == nil)

        let encoder = JSONEncoder()
        let data = try encoder.encode(gif)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(json.isEmpty)
    }
}
