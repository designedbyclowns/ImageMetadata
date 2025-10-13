import Testing
import Foundation
import ImageIO
@testable import Shared
@testable import ImageMetadata


struct TIFFTests {
    
    let tiff: TIFF
    init() throws {
        let url = try #require(Shared.url(forResource: "hang-in", withExtension: "jpg"))
        let imageFile = try ImageFile(url: url)
        let image = try ImageMetadata(imageFile: imageFile)
        self.tiff = try #require(image.tiff)
    }
    
    @Test func artist() throws {
        #expect(tiff.artist == nil)
    }
    
    @Test func compression() throws {
        #expect(tiff.compression == nil)
    }
    
    @Test func copyright() throws {
        #expect(tiff.copyright == nil)
    }
    
    @Test func dateTime() throws {
        #expect(tiff.dateTime == nil)
    }
    
    @Test func documentName() throws {
        #expect(tiff.documentName == nil)
    }
    
    @Test func hostComputer() throws {
        #expect(tiff.hostComputer == nil)
    }
    
    @Test func imageDescription() throws {
        #expect(tiff.imageDescription == "Test Caption")
    }
    
    @Test func make() throws {
        #expect(tiff.make == nil)
    }
    
    @Test func model() throws {
        #expect(tiff.model == nil)
    }
    
    @Test func orientation() throws {
        #expect(tiff.orientation == 1)
    }
    
    @Test func photometricInterpretation() throws {
        #expect(tiff.photometricInterpretation == nil)
    }
    
    @Test func primaryChromaticities() throws {
        #expect(tiff.primaryChromaticities == nil)
    }
    
    @Test func resolutionUnit() throws {
        #expect(tiff.resolutionUnit == 2)
    }
    
    @Test func software() throws {
        #expect(tiff.software == nil)
    }
    
    @Test func tileLength() throws {
        #expect(tiff.tileLength == nil)
    }
    
    @Test func tileWidth() throws {
        #expect(tiff.tileWidth == nil)
    }
    
    @Test func transferFunction() throws {
        #expect(tiff.transferFunction == nil)
    }
    
    @Test func whitePoint() throws {
        #expect(tiff.whitePoint == nil)
    }
    
    @Test func xResolution() throws {
        #expect(tiff.xResolution == 72.0)
    }
    
    @Test func yResolution() throws {
        #expect(tiff.yResolution == 72.0)
    }
 
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
            kCGImagePropertyTIFFHostComputer: "Hal 9000"
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
        #expect(tiff.hostComputer == "Hal 9000")
        
        let dateTime = try #require(tiff.dateTime)
        let dateComponents = Calendar.current.dateComponents(
            [.timeZone, .year, .month, .day, .hour, .minute, .second],
            from: dateTime
        )
        #expect(dateComponents.timeZone?.identifier == TimeZone.current.identifier)
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
        
        encoder.dateEncodingStrategy = .secondsSince1970
        
        
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
    }
}
