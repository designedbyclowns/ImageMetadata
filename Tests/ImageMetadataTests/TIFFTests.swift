import Testing
import Foundation
import ImageIO
@testable import Shared
@testable import ImageMetadata


struct TIFFTests {
    // Shared raw TIFF dictionary used across multiple tests (mirrors EXIFTests pattern)
    static func sampleRawTIFF() -> NSDictionary {
        
        return [
            kCGImagePropertyTIFFArtist: "Joseph Nicéphore Niépce",
            kCGImagePropertyTIFFCompression: 6,
            kCGImagePropertyTIFFImageDescription: "The earliest surviving camera photograph.",
            kCGImagePropertyTIFFPhotometricInterpretation: 2,
            kCGImagePropertyTIFFTransferFunction: "some-transfer",
            kCGImagePropertyTIFFOrientation: 1,
            kCGImagePropertyTIFFXResolution: 540.0,
            kCGImagePropertyTIFFYResolution: 540.0,
            kCGImagePropertyTIFFResolutionUnit: 2,
            kCGImagePropertyTIFFWhitePoint: 1,
            kCGImagePropertyTIFFPrimaryChromaticities: "primaries",
            kCGImagePropertyTIFFTileLength: "1024",
            kCGImagePropertyTIFFTileWidth: "2048",
            kCGImagePropertyTIFFDocumentName: "DocName",
            kCGImagePropertyTIFFImageDescription: "Desc",
            kCGImagePropertyTIFFArtist: "Artist",
            kCGImagePropertyTIFFCopyright: "Copyright",
            kCGImagePropertyTIFFDateTime: "2025:02:13 15:34:57",
            kCGImagePropertyTIFFMake: "MakeCo",
            kCGImagePropertyTIFFModel: "ModelX",
            kCGImagePropertyTIFFSoftware: "Software 1.0",
            kCGImagePropertyTIFFHostComputer: "Hal 9000"
        ]
    }
    
    let tiff: TIFF

    // Helper to create a TIFF from the shared dictionary
    init() {
        let dict = Self.sampleRawTIFF()
        self.tiff = TIFF(rawValue: dict)
    }
    
    @Test func artist() throws {
        #expect(tiff.artist == "Joseph Nicéphore Niépce")
    }
    
    @Test func compression() throws {
        #expect(tiff.compression == 6)
    }
    
    @Test func copyright() throws {
        #expect(tiff.copyright == "Copyright")
    }
    
    @Test func dateTime() throws {
        let dateTime = try #require(tiff.dateTime)

        let dateComponents = Calendar(identifier: .gregorian).dateComponents(
            [.timeZone, .year, .month, .day, .hour, .minute, .second, .nanosecond],
            from: dateTime
        )
        
        #expect(dateComponents.timeZone == .current)
        #expect(dateComponents.year == 2025)
        #expect(dateComponents.month == 2)
        #expect(dateComponents.day == 13)
        #expect(dateComponents.hour == 15)
        #expect(dateComponents.minute == 34)
        #expect(dateComponents.second == 57)
        #expect(dateComponents.nanosecond == 0)
    }
    
    @Test func documentName() throws {
        #expect(tiff.documentName == "DocName")
    }
    
    @Test func hostComputer() throws {
        #expect(tiff.hostComputer == "Hal 9000")
    }
    
    @Test func imageDescription() throws {
        #expect(tiff.imageDescription == "The earliest surviving camera photograph.")
    }
    
    @Test func make() throws {
        #expect(tiff.make == "MakeCo")
    }
    
    @Test func model() throws {
        #expect(tiff.model ==  "ModelX")
    }
    
    @Test func orientation() throws {
        #expect(tiff.orientation == 1)
    }
    
    @Test func photometricInterpretation() throws {
        #expect(tiff.photometricInterpretation == 2)
    }
    
    @Test func primaryChromaticities() throws {
        #expect(tiff.primaryChromaticities == "primaries")
    }
    
    @Test func resolutionUnit() throws {
        #expect(tiff.resolutionUnit == 2)
    }
    
    @Test func software() throws {
        #expect(tiff.software == "Software 1.0")
    }
    
    @Test func tileLength() throws {
        #expect(tiff.tileLength == "1024")
    }
    
    @Test func tileWidth() throws {
        #expect(tiff.tileWidth == "2048")
    }
    
    @Test func transferFunction() throws {
        #expect(tiff.transferFunction == "some-transfer")
    }
    
    @Test func whitePoint() throws {
        #expect(tiff.whitePoint == 1)
    }
    
    @Test func xResolution() throws {
        #expect(tiff.xResolution == 540.0)
    }
    
    @Test func yResolution() throws {
        #expect(tiff.yResolution == 540.0)
    }
 
    @Test("Encoding to JSON includes present fields and omits nils")
    func encoding() async throws {
        // Act
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        let data = try encoder.encode(tiff)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]

        // Assert
        let artist = json?["artist"] as? String
        let imageDescription = json?["imageDescription"] as? String
        let orientation = json?["orientation"] as? Int
        let photometric = json?["photometricInterpretation"] as? Int
        let resUnit = json?["resolutionUnit"] as? Int
        let xRes = json?["xResolution"] as? Double
        let yRes = json?["yResolution"] as? Double
        
        #expect(artist == "Joseph Nicéphore Niépce")
        #expect(imageDescription == "The earliest surviving camera photograph.")
        #expect(orientation == 1)
        #expect(photometric == 2)
        #expect(resUnit == 2)
        #expect(xRes == 540.0)
        #expect(yRes == 540.0)
        
        let dateTime = try #require(json?["dateTime"] as? String)
        
        let date = try Date.ISO8601FormatStyle.iso8601.parse(dateTime)
        
        let calendar = Calendar(identifier: .gregorian)
        
        let dateComponents = calendar.dateComponents(
            [.timeZone, .year, .month, .day, .hour, .minute, .second, .nanosecond],
            from: date
        )
        #expect(dateComponents.timeZone == .current)
        #expect(dateComponents.year == 2025)
        #expect(dateComponents.month == 2)
        #expect(dateComponents.day == 13)
        #expect(dateComponents.hour == 15)
        #expect(dateComponents.minute == 34)
        #expect(dateComponents.second == 57)
        #expect(dateComponents.nanosecond == 0)
    }

    @Test("Missing or malformed values produce nils")
    func missingOrMalformedValues() async throws {
        let raw = Self.sampleRawTIFF().mutableCopy() as! NSMutableDictionary
        raw[kCGImagePropertyTIFFCompression] = "not-an-int"
        raw[kCGImagePropertyTIFFXResolution] = "540"
        raw[kCGImagePropertyTIFFYResolution] = NSNull()
        raw[kCGImagePropertyTIFFDateTime] = "bad-format"

        let tiff = TIFF(rawValue: raw)

        #expect(tiff.compression == nil)
        #expect(tiff.xResolution == nil)
        #expect(tiff.yResolution == nil)
        #expect(tiff.dateTime == nil)
    }
    
    @Test("End-to-end: Parse TIFF from sample image")
    func parseTIFFFromSampleImage() async throws {
        guard let url = Shared.url(forResource: "WindowAtLeGras", withExtension: "jpg") else {
            Issue.record("Missing test resource: metadata-test.jpg")
            return
        }

        let metadata = try ImageMetadata(url: url)
        let tiff = try #require(metadata.tiff)

        #expect(tiff.artist == "Joseph Nicéphore Niépce")
        #expect(tiff.imageDescription == "The earliest surviving camera photograph.")
        #expect(tiff.orientation == 1)
        #expect(tiff.photometricInterpretation == 2)
        #expect(tiff.resolutionUnit == 2)
        #expect(tiff.xResolution == 540.0)
        #expect(tiff.yResolution == 540.0)
    }
}
