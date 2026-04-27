import Testing
import Foundation
import ImageIO
@testable import ImageMetadata


struct EightBIMTests {
    static func sampleRaw8BIM() -> NSDictionary {
        return [
            kCGImageProperty8BIMLayerNames: ["Background", "Layer 1", "Adjustment"],
            kCGImageProperty8BIMVersion: 1,
        ]
    }

    let eightBIM: EightBIM

    init() {
        self.eightBIM = EightBIM(rawValue: Self.sampleRaw8BIM())
    }

    @Test func layerNames() {
        #expect(eightBIM.layerNames == ["Background", "Layer 1", "Adjustment"])
    }

    @Test func version() {
        #expect(eightBIM.version == 1)
    }

    @Test("Encoding emits present fields and omits nils")
    func encoding() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(eightBIM)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

        #expect(json["layerNames"] as? [String] == ["Background", "Layer 1", "Adjustment"])
        #expect(json["version"] as? Int == 1)
    }

    @Test("Missing or malformed values produce nils")
    func missingOrMalformedValues() {
        let raw: NSMutableDictionary = [
            kCGImageProperty8BIMVersion: "not-an-int",
        ]

        let eightBIM = EightBIM(rawValue: raw)

        #expect(eightBIM.layerNames == nil)
        #expect(eightBIM.version == nil)
    }

    @Test("Empty dictionary produces an all-nil EightBIM that encodes to {}")
    func emptyDictionary() throws {
        let eightBIM = EightBIM(rawValue: [:])

        #expect(eightBIM.layerNames == nil)
        #expect(eightBIM.version == nil)

        let encoder = JSONEncoder()
        let data = try encoder.encode(eightBIM)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(json.isEmpty)
    }
}
