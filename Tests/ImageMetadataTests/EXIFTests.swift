import Testing
import Foundation
import Numerics
import ImageIO
@testable import Shared
@testable import ImageMetadata

struct EXIFTests {
    
    static func sampleRawEXIF() -> NSDictionary {
        return [
            kCGImagePropertyExifApertureValue as String: 1.35614,
            kCGImagePropertyExifBrightnessValue as String: 0.101368,
            kCGImagePropertyExifBodySerialNumber as String: "0000000123456789",
            kCGImagePropertyExifCameraOwnerName as String: "Owner Name",
            kCGImagePropertyExifColorSpace as String: 65535, // uncalibrated
            kCGImagePropertyExifComponentsConfiguration as String: [1, 2, 3, 0],
            kCGImagePropertyExifCompositeImage as String: 1, // general
            kCGImagePropertyExifExposureBiasValue as String: 0.0,
            kCGImagePropertyExifExposureMode as String: 0, // auto
            kCGImagePropertyExifExposureProgram as String: 2, // normalProgram
            kCGImagePropertyExifExposureTime as String: 0.025,
            kCGImagePropertyExifFlash as String: 16,
            kCGImagePropertyExifFlashPixVersion as String: [1, 0],
            kCGImagePropertyExifFNumber as String: 1.6,
            kCGImagePropertyExifFocalLength as String: 5.96,
            kCGImagePropertyExifFocalLenIn35mmFilm as String: 26,
            kCGImagePropertyExifISOSpeedRatings as String: [500],
            kCGImagePropertyExifLensMake as String: "Apple",
            kCGImagePropertyExifLensModel as String: "iPhone 15 back dual wide camera 5.96mm f/1.6",
            kCGImagePropertyExifMeteringMode as String: 5, // pattern
            kCGImagePropertyExifOffsetTime as String: "-04:00",
            kCGImagePropertyExifOffsetTimeOriginal as String: "-04:00",
            kCGImagePropertyExifOffsetTimeDigitized as String: "-04:00",
            kCGImagePropertyExifPixelXDimension as String: 5712,
            kCGImagePropertyExifPixelYDimension as String: 4284,
            kCGImagePropertyExifSceneCaptureType as String: 0, // standard
            kCGImagePropertyExifSceneType as String: 1,
            kCGImagePropertyExifSensingMethod as String: 2, // oneChipColorArea
            kCGImagePropertyExifShutterSpeedValue as String: 0.025,
            kCGImagePropertyExifSubjectArea as String: [2846, 2130, 3129, 1880],
            kCGImagePropertyExifWhiteBalance as String: 0, // auto
            kCGImagePropertyExifVersion as String: [2, 3, 2],
            // Dates with sub-seconds and offsets
            kCGImagePropertyExifDateTimeOriginal as String: "2024:04:19 08:11:15",
            kCGImagePropertyExifDateTimeDigitized as String: "2024:04:19 08:11:15",
            kCGImagePropertyExifSubsecTimeOriginal as String: "185",
            kCGImagePropertyExifSubsecTimeDigitized as String: "185"
        ] as NSDictionary
    }
    
    let exif: EXIF
    
    init() {
        let dict = Self.sampleRawEXIF()
        self.exif = EXIF(rawValue: dict)
    }
    
    @Test func apertureValue() throws {
        let apertureValue = try #require(exif.apertureValue)
        #expect(apertureValue.isApproximatelyEqual(to: 1.35614, absoluteTolerance: 0.00001))
    }
    
    @Test func bodySerialNumber() {
        #expect(exif.bodySerialNumber == "0000000123456789")
    }
        
    @Test func brightnessValue() throws {
        let brightnessValue = try #require(exif.brightnessValue)
        #expect(brightnessValue.isApproximatelyEqual(to: 0.101368, absoluteTolerance: 0.00001))
    }
    
    @Test func cameraOwnerName() {
        #expect(exif.cameraOwnerName == "Owner Name")
    }
    
    @Test func cfaPattern() {
        #expect(exif.cfaPattern == nil)
    }
    
    @Test func colorSpace() {
        #expect(exif.colorSpace == .uncalibrated)
    }
    
    @Test func componentsConfiguration() {
        #expect(exif.componentsConfiguration == [1, 2, 3, 0])
    }
    
    @Test func compositeImage() {
        #expect(exif.compositeImage == .no)
    }
    
    @Test func compressedBitsPerPixel() {
        #expect(exif.compressedBitsPerPixel == nil)
    }
    
    @Test func contrast() {
        #expect(exif.contrast == nil)
    }
    
    @Test func customRendered() {
        #expect(exif.customRendered == nil)
    }
       
    @Test func dateTimeDigitized() throws {
        let date = try #require(exif.dateTimeDigitized)
        let timeZone = try #require(exif.timeZoneDigitized)

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        
        let dateComponents = calendar.dateComponents(
            [.timeZone, .year, .month, .day, .hour, .minute, .second, .nanosecond],
            from: date
        )
        #expect(dateComponents.timeZone == timeZone)
        #expect(dateComponents.year == 2024)
        #expect(dateComponents.month == 4)
        #expect(dateComponents.day == 19)
        #expect(dateComponents.hour == 8)
        #expect(dateComponents.minute == 11)
        #expect(dateComponents.second == 15)
        #expect(dateComponents.nanosecond != nil)
        
        let normalizedSeconds: Double = try Double("\(dateComponents.second!).\(dateComponents.nanosecond!)", format: .number)
        #expect(normalizedSeconds.isApproximatelyEqual(to: 15.185, absoluteTolerance: 0.0000001))
    }
    
    @Test func dateTimeOriginal() throws {
        let date = try #require(exif.dateTimeOriginal)
        let timeZone = try #require(exif.timeZoneOriginal)
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        
        let dateComponents = calendar.dateComponents(
            [.timeZone, .year, .month, .day, .hour, .minute, .second, .nanosecond],
            from: date
        )
        #expect(dateComponents.timeZone == timeZone)
        #expect(dateComponents.year == 2024)
        #expect(dateComponents.month == 4)
        #expect(dateComponents.day == 19)
        #expect(dateComponents.hour == 8)
        #expect(dateComponents.minute == 11)
        #expect(dateComponents.second == 15)
        #expect(dateComponents.nanosecond != nil)
        
        let normalizedSeconds: Double = try Double("\(dateComponents.second!).\(dateComponents.nanosecond!)", format: .number)
        #expect(normalizedSeconds.isApproximatelyEqual(to: 15.185, absoluteTolerance: 0.0000001))
    }
    
    @Test func deviceSettingDescription() {
        #expect(exif.deviceSettingDescription == nil)
    }
    
    @Test func digitalZoomRatio() {
        #expect(exif.digitalZoomRatio == nil)
    }
    
    @Test func exposureBiasValue() {
        #expect(exif.exposureBiasValue == 0.0)
    }
    
    @Test func exposureIndex() {
        #expect(exif.exposureIndex == nil)
    }
    
    @Test func exposureMode() {
        #expect(exif.exposureMode == .auto)
    }
    
    @Test func exposureProgram() {
        #expect(exif.exposureProgram == .normalProgram)
    }
    
    @Test func exposureTime() {
        #expect(exif.exposureTime == 0.025)
    }
    
    @Test func fileSource() {
        #expect(exif.fileSource == nil)
    }
    
    @Test func firmware() {
        #expect(exif.firmware == nil)
    }
    
    @Test func flash() {
        #expect(exif.flash == 16)
    }
    
    @Test func flashCompensation() {
        #expect(exif.flashCompensation == nil)
    }
    
    @Test func flashEnergy() {
        #expect(exif.flashEnergy == nil)
    }
    
    @Test func flashPixVersion() {
        #expect(exif.flashPixVersion == "1.0")
    }
    
    @Test func fNumber() {
        #expect(exif.fNumber == 1.6)
    }
    
    @Test func focalLength() {
        #expect(exif.focalLength == 5.96)
    }
    
    @Test func focalLenIn35mmFilm() {
        #expect(exif.focalLenIn35mmFilm == 26)
    }
    
    @Test func focalPlaneResolutionUnit() {
        #expect(exif.focalPlaneResolutionUnit == nil)
    }
    
    @Test func focalPlaneXResolution() {
        #expect(exif.focalPlaneXResolution == nil)
    }
    
    @Test func focalPlaneYResolution() {
        #expect(exif.focalPlaneYResolution == nil)
    }
    
    @Test func gainControl() {
        #expect(exif.gainControl == nil)
    }
    
    @Test func gamma() {
        #expect(exif.gamma == nil)
    }
    
    @Test func imageNumber() {
        #expect(exif.imageNumber == nil)
    }
    
    @Test func imageUniqueID() {
        #expect(exif.imageUniqueID == nil)
    }
    
    @Test func isoSpeed() {
        #expect(exif.isoSpeed == nil)
    }
    
    @Test func isoSpeedLatitudeYYY() {
        #expect(exif.isoSpeedLatitudeYYY == nil)
    }
    
    @Test func isoSpeedLatitudeZZZ() {
        #expect(exif.isoSpeedLatitudeZZZ == nil)
    }
    
    @Test func isoSpeedRatings() {
        #expect(exif.isoSpeedRatings == [500])
    }
    
    @Test func lensID() {
        #expect(exif.lensID == nil)
    }
    
    @Test func lensInfo() {
        #expect(exif.lensInfo == nil)
    }
    
    @Test func lensMake() {
        #expect(exif.lensMake == "Apple")
    }
    
    @Test func lensModel() {
        #expect(exif.lensModel == "iPhone 15 back dual wide camera 5.96mm f/1.6")
    }
    
    @Test func lensSerialNumber() {
        #expect(exif.lensSerialNumber == nil)
    }
    
    @Test func lensSpecification() {
        #expect(exif.lensSpecification == nil)
    }
    
    @Test func lightSource() {
        #expect(exif.lightSource == nil)
    }
    
    @Test func makerNote() {
        #expect(exif.makerNote == nil)
    }
    
    @Test func maxApertureValue() {
        #expect(exif.maxApertureValue == nil)
    }
    
    @Test func meteringMode() {
        #expect(exif.meteringMode == .pattern)
    }
    
    @Test func oecf() {
        #expect(exif.oecf == nil)
    }
    
    @Test func offsetTime() {
        #expect(exif.offsetTime == "-04:00")
    }
    
    @Test func offsetTimeDigitized() {
        #expect(exif.offsetTimeOriginal == "-04:00")
    }
    
    @Test func offsetTimeOriginal() {
        #expect(exif.offsetTimeOriginal == "-04:00")
    }
    
    @Test func ownerName() {
        #expect(exif.ownerName == nil)
    }
    
    @Test func pixelXDimension() {
        #expect(exif.pixelXDimension == 5712)
    }
    
    @Test func pixelYDimension() {
        #expect(exif.pixelYDimension == 4284)
    }
    
    @Test func recommendedExposureIndex() {
        #expect(exif.recommendedExposureIndex == nil)
    }
    
    @Test func relatedSoundFile() {
        #expect(exif.relatedSoundFile == nil)
    }
    
    @Test func saturation() {
        #expect(exif.saturation == nil)
    }
    
    @Test func sceneCaptureType() {
        #expect(exif.sceneCaptureType == .standard)
    }
    
    @Test func sceneType() {
        #expect(exif.sceneType == 1)
    }
    
    @Test func sensingMethod() {
        #expect(exif.sensingMethod == .oneChipColorArea)
    }
    
    @Test func sensitivityType() {
        #expect(exif.sensitivityType == nil)
    }
    
    @Test func serialNumber() {
        #expect(exif.serialNumber == nil)
    }
    
    @Test func sharpness() {
        #expect(exif.sharpness == nil)
    }
    
    @Test func shutterSpeedValue() throws {
        let shutterSpeedValue = try #require(exif.shutterSpeedValue)
        #expect(shutterSpeedValue.isApproximatelyEqual(to: 0.025, absoluteTolerance: 0.00001))
    }
    
    @Test func sourceExposureTimesOfCompositeImage() {
        #expect(exif.sourceExposureTimesOfCompositeImage == nil)
    }
    
    @Test func sourceImageNumberOfCompositeImage() {
        #expect(exif.sourceImageNumberOfCompositeImage == nil)
    }
    
    @Test func spatialFrequencyResponse() {
        #expect(exif.spatialFrequencyResponse == nil)
    }
    
    @Test func spectralSensitivity() {
        #expect(exif.spectralSensitivity == nil)
    }
    
    @Test func standardOutputSensitivity() {
        #expect(exif.standardOutputSensitivity == nil)
    }
        
    @Test func subjectArea() {
        #expect(exif.subjectArea == [2846, 2130, 3129, 1880])
    }
    
    @Test func subjectDistance() {
        #expect(exif.subjectDistance == nil)
    }
    
    @Test func subjectDistanceRange() {
        #expect(exif.subjectDistanceRange == nil)
    }
    
    @Test func subjectLocation() {
        #expect(exif.subjectLocation == nil)
    }
    
    @Test func subsecTime() {
        #expect(exif.subsecTime == nil)
    }
    
    @Test func subsecTimeDigitized() {
        #expect(exif.subsecTimeDigitized == "185")
    }
    
    @Test func subsecTimeOriginal() {
        #expect(exif.subsecTimeOriginal == "185")
    }
    
    @Test func timeZone() {
        #expect(exif.timeZone == TimeZone(secondsFromGMT: -14400))
    }
    
    @Test func timeZoneDigitized() {
        #expect(exif.timeZoneDigitized == TimeZone(secondsFromGMT: -14400))
    }
    
    @Test func timeZoneOriginal() {
        #expect(exif.timeZoneOriginal == TimeZone(secondsFromGMT: -14400))
    }
    
    @Test func userComment() {
        #expect(exif.userComment == nil)
    }
    
    @Test func version() {
        #expect(exif.version == "2.3.2")
    }
    
    @Test func whiteBalance() {
        #expect(exif.whiteBalance == .auto)
    }

    @Test func exposureTime_malformedValuesBecomeNil() throws {
        // Malformed strings or unexpected types should not crash and should yield nil
        let badStrings: [Any] = ["abc", "1//40", "1/", "/40", "-1/40x"]
        for bad in badStrings {
            let dict: NSDictionary = [ kCGImagePropertyExifExposureTime as String: bad ]
            let exif = EXIF(rawValue: dict)
            #expect(exif.exposureTime == nil)
        }

        // Unexpected container types
        let weirds: [Any] = [["1/40"], [1, 40], ["num": "1/40"]]
        for bad in weirds {
            let dict: NSDictionary = [ kCGImagePropertyExifExposureTime as String: bad ]
            let exif = EXIF(rawValue: dict)
            #expect(exif.exposureTime == nil)
        }
    }

    @Test func enumBackedFields_parseFromNumericRawValues() throws {
        // Provide numeric values that map to known enum cases
        let dict: NSDictionary = [
            kCGImagePropertyExifMeteringMode as String: 5, // pattern
            kCGImagePropertyExifWhiteBalance as String: 0, // auto
            kCGImagePropertyExifSceneType as String: 1     // direct photograph
        ]
        let exif = EXIF(rawValue: dict)

        #expect(exif.meteringMode == .pattern)
        #expect(exif.whiteBalance == .auto)
        #expect(exif.sceneType == 1)
    }

    @Test func timezoneParsing_handlesMalformedOffsetStrings() throws {
        // Malformed offset strings should not crash; timezone should be nil and dates parsed without offset
        let dict: NSDictionary = [
            kCGImagePropertyExifOffsetTimeOriginal as String: "bad",
            kCGImagePropertyExifDateTimeOriginal as String: "2024:05:01 12:34:56",
            kCGImagePropertyExifSubsecTimeOriginal as String: "250"
        ]
        let exif = EXIF(rawValue: dict)

        #expect(exif.timeZoneOriginal == nil)
        let date = try #require(exif.dateTimeOriginal)
        // We cannot assert absolute components without a timezone, but we can assert subseconds were applied
        let comps = Calendar(identifier: .gregorian).dateComponents([.second, .nanosecond], from: date)
        #expect(comps.nanosecond != nil)
        let normalizedSeconds: Double = try Double("\(comps.second!).\(comps.nanosecond!)", format: .number)
        #expect(abs(normalizedSeconds - 56.250) < 1e-6)
    }
}

