import Testing
import Foundation
import ImageIO
@testable import ImageMetadata


struct HEICTests {
    static func sampleRawHEIC() -> NSDictionary {
        return [
            kCGImagePropertyHEICSCanvasPixelWidth: 1920,
            kCGImagePropertyHEICSCanvasPixelHeight: 1080,
            kCGImagePropertyHEICSDelayTime: 0.04,
            kCGImagePropertyHEICSUnclampedDelayTime: 0.0333,
            kCGImagePropertyHEICSLoopCount: 0,
            kCGImagePropertyHEICSFrameInfoArray: [
                ["delay": 0.04] as NSDictionary,
                ["delay": 0.04] as NSDictionary,
            ],
        ]
    }

    let heic: HEIC

    init() {
        self.heic = HEIC(rawValue: Self.sampleRawHEIC())
    }

    // MARK: - Canvas

    @Test func canvasPixelWidth() {
        #expect(heic.canvasPixelWidth == 1920)
    }

    @Test func canvasPixelHeight() {
        #expect(heic.canvasPixelHeight == 1080)
    }

    // MARK: - Animation

    @Test func delayTime() {
        #expect(heic.delayTime == 0.04)
    }

    @Test func unclampedDelayTime() {
        #expect(heic.unclampedDelayTime == 0.0333)
    }

    @Test func loopCount() {
        #expect(heic.loopCount == 0)
    }

    @Test func frameInfoArray() {
        #expect(heic.frameInfoArray?.count == 2)
    }

    // MARK: - Encoding

    @Test("Encoding emits present fields and omits nils")
    func encoding() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(heic)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

        #expect(json["canvasPixelWidth"] as? Int == 1920)
        #expect(json["canvasPixelHeight"] as? Int == 1080)
        #expect(json["delayTime"] as? Double == 0.04)
        #expect(json["unclampedDelayTime"] as? Double == 0.0333)
        #expect(json["loopCount"] as? Int == 0)
        #expect((json["frameInfoArray"] as? [String])?.count == 2)
    }

    @Test("Missing or malformed values produce nils")
    func missingOrMalformedValues() {
        let raw = Self.sampleRawHEIC().mutableCopy() as! NSMutableDictionary
        raw[kCGImagePropertyHEICSDelayTime] = "not-a-double"
        raw[kCGImagePropertyHEICSLoopCount] = NSNull()
        raw.removeObject(forKey: kCGImagePropertyHEICSCanvasPixelWidth)
        raw.removeObject(forKey: kCGImagePropertyHEICSFrameInfoArray)

        let heic = HEIC(rawValue: raw)

        #expect(heic.delayTime == nil)
        #expect(heic.loopCount == nil)
        #expect(heic.canvasPixelWidth == nil)
        #expect(heic.frameInfoArray == nil)
    }

    @Test("Empty dictionary produces an all-nil HEIC that encodes to {}")
    func emptyDictionary() throws {
        let heic = HEIC(rawValue: [:])

        #expect(heic.canvasPixelWidth == nil)
        #expect(heic.delayTime == nil)
        #expect(heic.frameInfoArray == nil)

        let encoder = JSONEncoder()
        let data = try encoder.encode(heic)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(json.isEmpty)
    }
}
