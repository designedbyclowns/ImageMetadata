import Testing
import Foundation
import ImageIO
@testable import ImageMetadata


struct JFIFTests {
    static func sampleRawJFIF() -> NSDictionary {
        return [
            kCGImagePropertyJFIFVersion: [1, 2],
            kCGImagePropertyJFIFXDensity: 72.0,
            kCGImagePropertyJFIFYDensity: 72.0,
            kCGImagePropertyJFIFDensityUnit: 1,
            kCGImagePropertyJFIFIsProgressive: true,
        ]
    }

    let jfif: JFIF

    init() {
        self.jfif = JFIF(rawValue: Self.sampleRawJFIF())
    }

    @Test func version() {
        #expect(jfif.version == "1.2")
    }

    @Test func xDensity() {
        #expect(jfif.xDensity == 72.0)
    }

    @Test func yDensity() {
        #expect(jfif.yDensity == 72.0)
    }

    @Test func densityUnit() {
        #expect(jfif.densityUnit == 1)
    }

    @Test func isProgressive() {
        #expect(jfif.isProgressive == true)
    }

    @Test("Encoding emits present fields and omits nils")
    func encoding() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(jfif)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

        #expect(json["version"] as? String == "1.2")
        #expect(json["xDensity"] as? Double == 72.0)
        #expect(json["yDensity"] as? Double == 72.0)
        #expect(json["densityUnit"] as? Int == 1)
        #expect(json["isProgressive"] as? Bool == true)
    }

    @Test("Missing or malformed values produce nils")
    func missingOrMalformedValues() throws {
        let raw = try #require(Self.sampleRawJFIF().mutableCopy() as? NSMutableDictionary)
        raw[kCGImagePropertyJFIFXDensity] = "not-a-double"
        raw[kCGImagePropertyJFIFDensityUnit] = NSNull()
        raw.removeObject(forKey: kCGImagePropertyJFIFVersion)

        let jfif = JFIF(rawValue: raw)

        #expect(jfif.xDensity == nil)
        #expect(jfif.densityUnit == nil)
        #expect(jfif.version == nil)
    }

    @Test("Empty dictionary produces an all-nil JFIF that encodes to {}")
    func emptyDictionary() throws {
        let jfif = JFIF(rawValue: [:])

        #expect(jfif.version == nil)
        #expect(jfif.xDensity == nil)

        let encoder = JSONEncoder()
        let data = try encoder.encode(jfif)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(json.isEmpty)
    }
}
