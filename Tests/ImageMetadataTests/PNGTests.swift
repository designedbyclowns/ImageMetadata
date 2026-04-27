import Testing
import Foundation
import ImageIO
@testable import ImageMetadata


struct PNGTests {
    static func sampleRawPNG() -> NSDictionary {
        return [
            kCGImagePropertyPNGAuthor: "Joseph Nicéphore Niépce",
            kCGImagePropertyPNGComment: "Test image",
            kCGImagePropertyPNGCopyright: "Public Domain",
            kCGImagePropertyPNGDescription: "An example PNG",
            kCGImagePropertyPNGDisclaimer: "Use at your own risk.",
            kCGImagePropertyPNGSoftware: "Adobe Photoshop",
            kCGImagePropertyPNGSource: "Camera Obscura",
            kCGImagePropertyPNGTitle: "View from the Window at Le Gras",
            kCGImagePropertyPNGWarning: "Contains sample bits.",

            kCGImagePropertyPNGCreationTime: "2025-02-13T15:34:57Z",
            kCGImagePropertyPNGModificationTime: "Sun, 13 Feb 2025 15:34:57 GMT",

            kCGImagePropertyPNGChromaticities: [0.3127, 0.3290, 0.64, 0.33, 0.30, 0.60, 0.15, 0.06],
            kCGImagePropertyPNGGamma: 2.2,
            kCGImagePropertyPNGsRGBIntent: 0,
            kCGImagePropertyPNGTransparency: [0, 255, 0],

            kCGImagePropertyPNGCompressionFilter: 5,
            kCGImagePropertyPNGInterlaceType: 1,

            kCGImagePropertyPNGPixelsAspectRatio: 1.0,
            kCGImagePropertyPNGXPixelsPerMeter: 2835,
            kCGImagePropertyPNGYPixelsPerMeter: 2835,
        ]
    }

    let png: PNG

    init() {
        self.png = PNG(rawValue: Self.sampleRawPNG())
    }

    // MARK: - Text fields

    @Test func author() {
        #expect(png.author == "Joseph Nicéphore Niépce")
    }

    @Test func comment() {
        #expect(png.comment == "Test image")
    }

    @Test func copyright() {
        #expect(png.copyright == "Public Domain")
    }

    @Test func imageDescription() {
        #expect(png.imageDescription == "An example PNG")
    }

    @Test func disclaimer() {
        #expect(png.disclaimer == "Use at your own risk.")
    }

    @Test func software() {
        #expect(png.software == "Adobe Photoshop")
    }

    @Test func source() {
        #expect(png.source == "Camera Obscura")
    }

    @Test func title() {
        #expect(png.title == "View from the Window at Le Gras")
    }

    @Test func warning() {
        #expect(png.warning == "Contains sample bits.")
    }

    // MARK: - Timestamps

    @Test("creationTime parses ISO 8601")
    func creationTimeISO8601() throws {
        let date = try #require(png.creationTime)
        let components = Calendar(identifier: .gregorian).dateComponents(
            in: TimeZone(identifier: "UTC")!,
            from: date
        )
        #expect(components.year == 2025)
        #expect(components.month == 2)
        #expect(components.day == 13)
        #expect(components.hour == 15)
        #expect(components.minute == 34)
        #expect(components.second == 57)
    }

    @Test("modificationTime falls back to RFC 1123")
    func modificationTimeRFC1123() throws {
        let date = try #require(png.modificationTime)
        let components = Calendar(identifier: .gregorian).dateComponents(
            in: TimeZone(identifier: "UTC")!,
            from: date
        )
        #expect(components.year == 2025)
        #expect(components.month == 2)
        #expect(components.day == 13)
        #expect(components.hour == 15)
        #expect(components.minute == 34)
        #expect(components.second == 57)
    }

    // MARK: - Color

    @Test func chromaticities() {
        #expect(png.chromaticities == [0.3127, 0.3290, 0.64, 0.33, 0.30, 0.60, 0.15, 0.06])
    }

    @Test func gamma() {
        #expect(png.gamma == 2.2)
    }

    @Test func sRGBIntent() {
        #expect(png.sRGBIntent == 0)
    }

    @Test func transparency() {
        #expect(png.transparency == [0, 255, 0])
    }

    // MARK: - Encoding

    @Test func compressionFilter() {
        #expect(png.compressionFilter == 5)
    }

    @Test func interlaceType() {
        #expect(png.interlaceType == 1)
    }

    // MARK: - Physical size

    @Test func pixelsAspectRatio() {
        #expect(png.pixelsAspectRatio == 1.0)
    }

    @Test func pixelsPerMeter() {
        #expect(png.xPixelsPerMeter == 2835)
        #expect(png.yPixelsPerMeter == 2835)
    }

    // MARK: - Encoding behavior

    @Test("Encoding emits present fields and omits nils")
    func encoding() throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        let data = try encoder.encode(png)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

        #expect(json["author"] as? String == "Joseph Nicéphore Niépce")
        #expect(json["title"] as? String == "View from the Window at Le Gras")
        #expect(json["description"] as? String == "An example PNG")
        #expect(json["gamma"] as? Double == 2.2)
        #expect(json["sRGBIntent"] as? Int == 0)
        #expect(json["chromaticities"] as? [Double] == [0.3127, 0.3290, 0.64, 0.33, 0.30, 0.60, 0.15, 0.06])
        #expect(json["transparency"] as? [Int] == [0, 255, 0])
        #expect(json["xPixelsPerMeter"] as? Int == 2835)

        let creation = try #require(json["creationTime"] as? String)
        #expect(creation.hasPrefix("2025-02-13T15:34:57"))
    }

    @Test("Missing or malformed values produce nils")
    func missingOrMalformedValues() {
        let raw = Self.sampleRawPNG().mutableCopy() as! NSMutableDictionary
        raw[kCGImagePropertyPNGGamma] = "not-a-double"
        raw[kCGImagePropertyPNGCreationTime] = "garbage"
        raw[kCGImagePropertyPNGsRGBIntent] = NSNull()
        raw.removeObject(forKey: kCGImagePropertyPNGAuthor)

        let png = PNG(rawValue: raw)

        #expect(png.gamma == nil)
        #expect(png.creationTime == nil)
        #expect(png.sRGBIntent == nil)
        #expect(png.author == nil)
    }

    @Test("Empty dictionary produces an all-nil PNG that encodes to {}")
    func emptyDictionary() throws {
        let png = PNG(rawValue: [:])

        #expect(png.author == nil)
        #expect(png.gamma == nil)
        #expect(png.creationTime == nil)

        let encoder = JSONEncoder()
        let data = try encoder.encode(png)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(json.isEmpty)
    }
}
