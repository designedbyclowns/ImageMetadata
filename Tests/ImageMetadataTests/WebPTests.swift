import Testing
import Foundation
import ImageIO
@testable import ImageMetadata


struct WebPTests {
    static func sampleRawWebP() -> NSDictionary {
        return [
            kCGImagePropertyWebPCanvasPixelWidth: 800,
            kCGImagePropertyWebPCanvasPixelHeight: 600,
            kCGImagePropertyWebPDelayTime: 0.05,
            kCGImagePropertyWebPUnclampedDelayTime: 0.04,
            kCGImagePropertyWebPLoopCount: 0,
            kCGImagePropertyWebPFrameInfoArray: [
                ["delay": 0.05] as NSDictionary,
                ["delay": 0.05] as NSDictionary,
                ["delay": 0.10] as NSDictionary,
            ],
        ]
    }

    let webP: WebP

    init() {
        self.webP = WebP(rawValue: Self.sampleRawWebP())
    }

    @Test func canvasPixelWidth() {
        #expect(webP.canvasPixelWidth == 800)
    }

    @Test func canvasPixelHeight() {
        #expect(webP.canvasPixelHeight == 600)
    }

    @Test func delayTime() {
        #expect(webP.delayTime == 0.05)
    }

    @Test func unclampedDelayTime() {
        #expect(webP.unclampedDelayTime == 0.04)
    }

    @Test func loopCount() {
        #expect(webP.loopCount == 0)
    }

    @Test func frameInfoArray() {
        #expect(webP.frameInfoArray?.count == 3)
    }

    @Test("Encoding emits present fields and omits nils")
    func encoding() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(webP)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

        #expect(json["canvasPixelWidth"] as? Int == 800)
        #expect(json["canvasPixelHeight"] as? Int == 600)
        #expect(json["delayTime"] as? Double == 0.05)
        #expect(json["unclampedDelayTime"] as? Double == 0.04)
        #expect(json["loopCount"] as? Int == 0)

        let frames = try #require(json["frameInfoArray"] as? [String])
        #expect(frames.count == 3)
    }

    @Test("Missing or malformed values produce nils")
    func missingOrMalformedValues() throws {
        let raw = try #require(Self.sampleRawWebP().mutableCopy() as? NSMutableDictionary)
        raw[kCGImagePropertyWebPDelayTime] = "not-a-double"
        raw[kCGImagePropertyWebPLoopCount] = NSNull()
        raw.removeObject(forKey: kCGImagePropertyWebPCanvasPixelWidth)
        raw.removeObject(forKey: kCGImagePropertyWebPFrameInfoArray)

        let webP = WebP(rawValue: raw)

        #expect(webP.delayTime == nil)
        #expect(webP.loopCount == nil)
        #expect(webP.canvasPixelWidth == nil)
        #expect(webP.frameInfoArray == nil)
    }

    @Test("Empty dictionary produces an all-nil WebP that encodes to {}")
    func emptyDictionary() throws {
        let webP = WebP(rawValue: [:])

        #expect(webP.canvasPixelWidth == nil)
        #expect(webP.delayTime == nil)
        #expect(webP.frameInfoArray == nil)

        let encoder = JSONEncoder()
        let data = try encoder.encode(webP)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(json.isEmpty)
    }
}
