import Testing
import Foundation
import ImageIO
@testable import Shared
@testable import ImageMetadata


struct TIFFTests {

    @Test("Init from raw TIFF dictionary parses values and date")
    func initFromRawDictionary() async throws {
        let raw: NSDictionary = [
            kCGImagePropertyTIFFCompression: 6,
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
            kCGImagePropertyTIFFHostComputer: "Mac"
        ]

        let tiff = TIFF(rawValue: raw)

        #expect(tiff.compression == 6)
        #expect(tiff.photometricInterpretation == 2)
        #expect(tiff.transferFunction == "some-transfer")
        #expect(tiff.orientation == 1)
        #expect(tiff.xResolution == 540.0)
        #expect(tiff.yResolution == 540.0)
        #expect(tiff.resolutionUnit == 2)
        #expect(tiff.whitePoint == 1)
        #expect(tiff.primaryChromaticities == "primaries")
        #expect(tiff.tileLength == "1024")
        #expect(tiff.tileWidth == "2048")
        #expect(tiff.documentName == "DocName")
        #expect(tiff.imageDescription == "Desc")
        #expect(tiff.artist == "Artist")
        #expect(tiff.copyright == "Copyright")
        #expect(tiff.make == "MakeCo")
        #expect(tiff.model == "ModelX")
        #expect(tiff.software == "Software 1.0")
        #expect(tiff.hostComputer == "Mac")
        
        let dateTime = try #require(tiff.dateTime)
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: dateTime
        )
        
        #expect(dateComponents.year == 2025)
        #expect(dateComponents.month == 2)
        #expect(dateComponents.day == 13)
        #expect(dateComponents.hour == 15)
        #expect(dateComponents.minute == 34)
        #expect(dateComponents.second == 57)
    }

    @Test("Encoding to JSON includes present fields and omits nils")
    func encoding() async throws {
        let raw: NSDictionary = [
            kCGImagePropertyTIFFArtist: "Joseph Nicéphore Niépce",
            kCGImagePropertyTIFFImageDescription: "The earliest surviving camera photograph.",
            kCGImagePropertyTIFFOrientation: 1,
            kCGImagePropertyTIFFPhotometricInterpretation: 2,
            kCGImagePropertyTIFFResolutionUnit: 2,
            kCGImagePropertyTIFFXResolution: 540.0,
            kCGImagePropertyTIFFYResolution: 540.0,
            kCGImagePropertyTIFFDateTime: "2025:02:13 15:34:57"
        ]
        let tiff = TIFF(rawValue: raw)

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
        let dateTime = json?["dateTime"] as? String

        #expect(artist == "Joseph Nicéphore Niépce")
        #expect(imageDescription == "The earliest surviving camera photograph.")
        #expect(orientation == 1)
        #expect(photometric == 2)
        #expect(resUnit == 2)
        #expect(xRes == 540.0)
        #expect(yRes == 540.0)
        #expect(dateTime == "2025-02-13T23:34:57Z")
        
        // Omitted keys should be absent
        #expect(json?["compression"] == nil)
        #expect(json?["software"] == nil)
        #expect(json?["tileLength"] == nil)
        #expect(json?["tileWidth"] == nil)
    }

    @Test("Missing or malformed values produce nils")
    func missingOrMalformedValues() async throws {
        let raw: NSDictionary = [
            kCGImagePropertyTIFFCompression: "not-an-int",
            kCGImagePropertyTIFFXResolution: "540",
            kCGImagePropertyTIFFYResolution: NSNull(),
            kCGImagePropertyTIFFDateTime: "bad-format"
        ]

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

        if let date = tiff.dateTime {
            let formatted = TIFF.dateFormatter.string(from: date)
            #expect(formatted == "2025:02:13 07:34:57")
        }
    }
}
