import Foundation
import ImageIO
import Testing
@testable import ImageMetadata

@Suite("GPS Metadata Parsing")
struct GPSTests {
    func sampleRawGPS() -> NSDictionary {
        return [
            kCGImagePropertyGPSAltitude as String: 12.3,
            kCGImagePropertyGPSAltitudeRef as String: "0",
            kCGImagePropertyGPSLatitude as String: 37.3317,
            kCGImagePropertyGPSLongitude as String: -122.0307,
            kCGImagePropertyGPSLatitudeRef as String: "N",
            kCGImagePropertyGPSLongitudeRef as String: "E",
            kCGImagePropertyGPSHPositioningError as String: 5.5,
            kCGImagePropertyGPSDateStamp as String: "2020:01:02",
            kCGImagePropertyGPSTimeStamp as String: "03:04:05",
        ] as NSDictionary
    }

    @Test func initParsesBasicFields() {
        let gps = GPS(rawValue: sampleRawGPS())

        #expect(gps.altitude == 12.3)
        #expect(gps.altitudeReference == "0")
        #expect(gps.latitude == 37.3317)
        #expect(gps.longitude == -122.0307)
        #expect(gps.latitudeReference == .north)
        #expect(gps.longitudeReference == .east)
        #expect(gps.horizontalPositioningError == 5.5)
        #expect(gps.dateStamp == "2020:01:02")
        #expect(gps.timeStamp == "03:04:05")
    }

    @Test func computesDateFromDateAndTimeStamp() {
        let gps = GPS(rawValue: sampleRawGPS())
        #expect(gps.date != nil)

        if let date = gps.date {
            let formatted = GPS.dateFormatter.string(from: date)
            #expect(formatted == "2020:01:02 03:04:05")
        }
    }

    @Test func handlesMissingFields() {
        let gps = GPS(rawValue: NSDictionary())
        #expect(gps.altitude == nil)
        #expect(gps.altitudeReference == nil)
        #expect(gps.latitude == nil)
        #expect(gps.longitude == nil)
        #expect(gps.latitudeReference == nil)
        #expect(gps.longitudeReference == nil)
        #expect(gps.horizontalPositioningError == nil)
        #expect(gps.dateStamp == nil)
        #expect(gps.timeStamp == nil)
        #expect(gps.date == nil)
    }

    @Test func latitudeLongitudeReferenceSigns() {
        #expect(GPS.LatitudeReference.north.sign == .plus)
        #expect(GPS.LatitudeReference.south.sign == .minus)

        #expect(GPS.LongitudeReference.east.sign == .minus)
        #expect(GPS.LongitudeReference.west.sign == .plus)
    }
}
