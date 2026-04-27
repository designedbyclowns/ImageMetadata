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

        let second = try #require(dateComponents.second)
        let nanosecond = try #require(dateComponents.nanosecond)
        let normalizedSeconds: Double = try Double("\(second).\(nanosecond)", format: .number)
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

        let second = try #require(dateComponents.second)
        let nanosecond = try #require(dateComponents.nanosecond)
        let normalizedSeconds: Double = try Double("\(second).\(nanosecond)", format: .number)
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

    @Test(arguments: ["abc", "1//40", "1/", "/40", "-1/40x"])
    func exposureTime_malformedStringsBecomeNil(_ badString: String) {
        let dict: NSDictionary = [kCGImagePropertyExifExposureTime as String: badString]
        #expect(EXIF(rawValue: dict).exposureTime == nil)
    }

    @Test func exposureTime_unexpectedContainersBecomeNil() {
        let containers: [NSDictionary] = [
            [kCGImagePropertyExifExposureTime as String: ["1/40"]],
            [kCGImagePropertyExifExposureTime as String: [1, 40]],
            [kCGImagePropertyExifExposureTime as String: ["num": "1/40"]]
        ]
        for dict in containers {
            #expect(EXIF(rawValue: dict).exposureTime == nil)
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
        let second = try #require(comps.second)
        let nanosecond = try #require(comps.nanosecond)
        let normalizedSeconds: Double = try Double("\(second).\(nanosecond)", format: .number)
        #expect(abs(normalizedSeconds - 56.250) < 1e-6)
    }

    @Test func meteringMode_parsesFromStringNumberAndUnknown() {
        // Known case by number (5 -> pattern)
        let numDict: NSDictionary = [ kCGImagePropertyExifMeteringMode as String: 5 ]
        #expect(EXIF(rawValue: numDict).meteringMode == .pattern)

        // Unknown value
        let unknownDict: NSDictionary = [ kCGImagePropertyExifMeteringMode as String: 123 ]
        #expect(EXIF(rawValue: unknownDict).meteringMode == nil)
    }

    @Test func exposureMode_parsesFromStringNumberAndUnknown() {
        // Known case by number (0 -> auto)
        let numDict: NSDictionary = [ kCGImagePropertyExifExposureMode as String: 0 ]
        #expect(EXIF(rawValue: numDict).exposureMode == .auto)

        // Unknown value
        let unknownDict: NSDictionary = [ kCGImagePropertyExifExposureMode as String: 99 ]
        #expect(EXIF(rawValue: unknownDict).exposureMode == nil)
    }

    @Test func sceneCaptureType_parsesFromStringNumberAndUnknown() {
        // Known case by number (0 -> standard)
        let numDict: NSDictionary = [ kCGImagePropertyExifSceneCaptureType as String: 0 ]
        #expect(EXIF(rawValue: numDict).sceneCaptureType == .standard)

        // Unknown value
        let unknownDict: NSDictionary = [ kCGImagePropertyExifSceneCaptureType as String: 77 ]
        #expect(EXIF(rawValue: unknownDict).sceneCaptureType == nil)
    }

    @Test func compositeImage_parsesFromStringNumberAndUnknown() {
        // Per the sample data above, raw value 1 maps to .no in this project's model.
        let numDict: NSDictionary = [ kCGImagePropertyExifCompositeImage as String: 1 ]
        #expect(EXIF(rawValue: numDict).compositeImage == .no)

        let unknownDict: NSDictionary = [ kCGImagePropertyExifCompositeImage as String: 999 ]
        #expect(EXIF(rawValue: unknownDict).compositeImage == nil)
    }

    // MARK: - Additional Edge Case Tests

    @Test func emptyDictionary_producesAllNilProperties() {
        let emptyDict: NSDictionary = [:]
        let exif = EXIF(rawValue: emptyDict)
        
        // Sample a few key properties to ensure they're nil
        #expect(exif.apertureValue == nil)
        #expect(exif.bodySerialNumber == nil)
        #expect(exif.dateTimeOriginal == nil)
        #expect(exif.exposureTime == nil)
        #expect(exif.fNumber == nil)
        #expect(exif.isoSpeedRatings == nil)
        #expect(exif.version == nil)
    }

    @Test func auxiliaryDictionary_lensModelAndSerialNumberFromAux() {
        let aux: NSDictionary = [
            kCGImagePropertyExifAuxLensModel as String: "AUX Lens Model",
            kCGImagePropertyExifAuxLensSerialNumber as String: "AUX12345"
        ]
        let exif = EXIF(rawValue: [:], aux: aux)

        #expect(exif.lensModel == "AUX Lens Model")
        #expect(exif.lensSerialNumber == "AUX12345")
    }

    @Test func auxiliaryDictionary_fallbackToMainExifKeys() {
        let dict: NSDictionary = [
            kCGImagePropertyExifLensModel as String: "Main Lens Model",
            kCGImagePropertyExifLensSerialNumber as String: "MAIN67890"
        ]
        let exif = EXIF(rawValue: dict)

        #expect(exif.lensModel == "Main Lens Model")
        #expect(exif.lensSerialNumber == "MAIN67890")
    }

    @Test func auxiliaryDictionary_auxTakesPrecedenceOverMain() {
        let dict: NSDictionary = [
            kCGImagePropertyExifLensModel as String: "Main Lens Model",
        ]
        let aux: NSDictionary = [
            kCGImagePropertyExifAuxLensModel as String: "AUX Lens Model"
        ]
        let exif = EXIF(rawValue: dict, aux: aux)

        #expect(exif.lensModel == "AUX Lens Model")
    }

    @Test func auxiliaryDictionary_allAuxProperties() {
        let aux: NSDictionary = [
            kCGImagePropertyExifAuxFirmware as String: "v1.2.3",
            kCGImagePropertyExifAuxFlashCompensation as String: "+0.5",
            kCGImagePropertyExifAuxImageNumber as String: "IMG_1234",
            kCGImagePropertyExifAuxLensID as String: "LENS001",
            kCGImagePropertyExifAuxLensInfo as String: "24-70mm f/2.8",
            kCGImagePropertyExifAuxOwnerName as String: "John Doe",
            kCGImagePropertyExifAuxSerialNumber as String: "SN123456"
        ]
        let exif = EXIF(rawValue: [:], aux: aux)

        #expect(exif.firmware == "v1.2.3")
        #expect(exif.flashCompensation == "+0.5")
        #expect(exif.imageNumber == "IMG_1234")
        #expect(exif.lensID == "LENS001")
        #expect(exif.lensInfo == "24-70mm f/2.8")
        #expect(exif.ownerName == "John Doe")
        #expect(exif.serialNumber == "SN123456")
    }

    @Test func version_parsesSingleDigitArray() {
        let dict: NSDictionary = [ kCGImagePropertyExifVersion as String: [2, 3, 2] ]
        let exif = EXIF(rawValue: dict)
        #expect(exif.version == "2.3.2")
    }

    @Test func version_handlesEmptyArray() {
        let dict: NSDictionary = [ kCGImagePropertyExifVersion as String: [] ]
        let exif = EXIF(rawValue: dict)
        #expect(exif.version == "")
    }

    @Test func version_handlesMixedTypes() {
        let dict: NSDictionary = [ kCGImagePropertyExifVersion as String: [2, "3", 2] ]
        let exif = EXIF(rawValue: dict)
        #expect(exif.version == "2.3.2")
    }

    @Test func flashPixVersion_parsesTwoDigitArray() {
        let dict: NSDictionary = [ kCGImagePropertyExifFlashPixVersion as String: [1, 0] ]
        let exif = EXIF(rawValue: dict)
        #expect(exif.flashPixVersion == "1.0")
    }

    @Test func flashPixVersion_handlesEmptyArray() {
        let dict: NSDictionary = [ kCGImagePropertyExifFlashPixVersion as String: [] ]
        let exif = EXIF(rawValue: dict)
        #expect(exif.flashPixVersion == "")
    }

    @Test func dateTimeParsing_withoutTimeZone_usesGMT() throws {
        let dict: NSDictionary = [
            kCGImagePropertyExifDateTimeOriginal as String: "2025:06:15 14:30:45",
            kCGImagePropertyExifSubsecTimeOriginal as String: "500"
        ]
        let exif = EXIF(rawValue: dict)
        
        let date = try #require(exif.dateTimeOriginal)
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .gmt, from: date)
        
        #expect(components.year == 2025)
        #expect(components.month == 6)
        #expect(components.day == 15)
        #expect(components.hour == 14)
        #expect(components.minute == 30)
    }

    @Test func dateTimeParsing_withPositiveOffset() throws {
        let dict: NSDictionary = [
            kCGImagePropertyExifDateTimeOriginal as String: "2025:06:15 14:30:45",
            kCGImagePropertyExifSubsecTimeOriginal as String: "500",
            kCGImagePropertyExifOffsetTimeOriginal as String: "+09:00"
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.timeZoneOriginal == TimeZone(secondsFromGMT: 9 * 3600))
        #expect(exif.dateTimeOriginal != nil)
    }

    @Test func dateTimeParsing_withNegativeOffset() throws {
        let dict: NSDictionary = [
            kCGImagePropertyExifDateTimeDigitized as String: "2025:06:15 14:30:45",
            kCGImagePropertyExifSubsecTimeDigitized as String: "250",
            kCGImagePropertyExifOffsetTimeDigitized as String: "-08:00"
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.timeZoneDigitized == TimeZone(secondsFromGMT: -8 * 3600))
        #expect(exif.dateTimeDigitized != nil)
    }

    @Test func dateTimeParsing_withZeroSubseconds() throws {
        let dict: NSDictionary = [
            kCGImagePropertyExifDateTimeOriginal as String: "2025:01:01 00:00:00",
            kCGImagePropertyExifSubsecTimeOriginal as String: "0"
        ]
        let exif = EXIF(rawValue: dict)
        
        let date = try #require(exif.dateTimeOriginal)
        // Date was successfully unwrapped, verify it has the expected components
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .gmt, from: date)
        #expect(components.year == 2025)
        #expect(components.month == 1)
        #expect(components.day == 1)
    }

    @Test func dateTimeParsing_withoutSubseconds_defaultsToZero() throws {
        let dict: NSDictionary = [
            kCGImagePropertyExifDateTimeOriginal as String: "2025:01:01 12:00:00"
        ]
        let exif = EXIF(rawValue: dict)
        
        let date = try #require(exif.dateTimeOriginal)
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .gmt, from: date)
        
        #expect(components.nanosecond == 0)
    }

    @Test func dateTimeParsing_malformedDateString_returnsNil() {
        let dict: NSDictionary = [
            kCGImagePropertyExifDateTimeOriginal as String: "invalid-date"
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.dateTimeOriginal == nil)
    }

    @Test func dateTimeParsing_emptyDateString_returnsNil() {
        let dict: NSDictionary = [
            kCGImagePropertyExifDateTimeOriginal as String: ""
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.dateTimeOriginal == nil)
    }

    @Test func timeZoneParsing_withOnlyHours() {
        let dict: NSDictionary = [
            kCGImagePropertyExifOffsetTime as String: "+05"
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.timeZone == TimeZone(secondsFromGMT: 5 * 3600))
    }

    @Test func timeZoneParsing_withHoursAndMinutes() {
        let dict: NSDictionary = [
            kCGImagePropertyExifOffsetTime as String: "+05:30"
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.timeZone == TimeZone(secondsFromGMT: 5 * 3600 + 30 * 60))
    }

    @Test func timeZoneParsing_withNegativeHoursAndMinutes() {
        let dict: NSDictionary = [
            kCGImagePropertyExifOffsetTime as String: "-03:30"
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.timeZone == TimeZone(secondsFromGMT: -3 * 3600 - 30 * 60))
    }

    @Test func timeZoneParsing_emptyString_returnsNil() {
        let dict: NSDictionary = [
            kCGImagePropertyExifOffsetTime as String: ""
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.timeZone == nil)
    }

    @Test func timeZoneParsing_malformedString_returnsNil() {
        let dict: NSDictionary = [
            kCGImagePropertyExifOffsetTime as String: "invalid"
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.timeZone == nil)
    }

    @Test func timeZoneParsing_tooManyComponents_returnsNil() {
        let dict: NSDictionary = [
            kCGImagePropertyExifOffsetTime as String: "+05:30:45"
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.timeZone == nil)
    }

    @Test func colorSpace_sRGB() {
        let dict: NSDictionary = [ kCGImagePropertyExifColorSpace as String: 1 ]
        let exif = EXIF(rawValue: dict)
        #expect(exif.colorSpace == .sRGB)
    }

    @Test func colorSpace_uncalibrated() {
        let dict: NSDictionary = [ kCGImagePropertyExifColorSpace as String: 65535 ]
        let exif = EXIF(rawValue: dict)
        #expect(exif.colorSpace == .uncalibrated)
    }

    @Test func colorSpace_unknownValue_returnsNil() {
        let dict: NSDictionary = [ kCGImagePropertyExifColorSpace as String: 999 ]
        let exif = EXIF(rawValue: dict)
        #expect(exif.colorSpace == nil)
    }

    @Test func allEnumTypes_handleUnknownRawValues() {
        let dict: NSDictionary = [
            kCGImagePropertyExifContrast as String: 999,
            kCGImagePropertyExifCustomRendered as String: 999,
            kCGImagePropertyExifLightSource as String: 999,
            kCGImagePropertyExifSaturation as String: 999,
            kCGImagePropertyExifSharpness as String: 999,
            kCGImagePropertyExifSubjectDistRange as String: 999
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.contrast == nil)
        #expect(exif.customRendered == nil)
        #expect(exif.lightSource == nil)
        #expect(exif.saturation == nil)
        #expect(exif.sharpness == nil)
        #expect(exif.subjectDistanceRange == nil)
    }

    @Test func arrayProperties_handleEmptyArrays() {
        let dict: NSDictionary = [
            kCGImagePropertyExifComponentsConfiguration as String: [],
            kCGImagePropertyExifISOSpeedRatings as String: [],
            kCGImagePropertyExifSubjectArea as String: []
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.componentsConfiguration == [])
        #expect(exif.isoSpeedRatings == [])
        #expect(exif.subjectArea == [])
    }

    @Test func arrayProperties_handleSingleElement() {
        let dict: NSDictionary = [
            kCGImagePropertyExifComponentsConfiguration as String: [1],
            kCGImagePropertyExifISOSpeedRatings as String: [100],
            kCGImagePropertyExifSubjectArea as String: [2000]
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.componentsConfiguration == [1])
        #expect(exif.isoSpeedRatings == [100])
        #expect(exif.subjectArea == [2000])
    }

    @Test func arrayProperties_handleMultipleElements() {
        let dict: NSDictionary = [
            kCGImagePropertyExifComponentsConfiguration as String: [1, 2, 3, 0],
            kCGImagePropertyExifISOSpeedRatings as String: [100, 200, 400],
            kCGImagePropertyExifSubjectArea as String: [1000, 2000, 3000, 4000]
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.componentsConfiguration == [1, 2, 3, 0])
        #expect(exif.isoSpeedRatings == [100, 200, 400])
        #expect(exif.subjectArea == [1000, 2000, 3000, 4000])
    }

    @Test func numericProperties_handleZeroValues() {
        let dict: NSDictionary = [
            kCGImagePropertyExifApertureValue as String: 0.0,
            kCGImagePropertyExifBrightnessValue as String: 0.0,
            kCGImagePropertyExifExposureBiasValue as String: 0.0,
            kCGImagePropertyExifExposureTime as String: 0.0,
            kCGImagePropertyExifFNumber as String: 0.0,
            kCGImagePropertyExifFocalLength as String: 0.0
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.apertureValue == 0.0)
        #expect(exif.brightnessValue == 0.0)
        #expect(exif.exposureBiasValue == 0.0)
        #expect(exif.exposureTime == 0.0)
        #expect(exif.fNumber == 0.0)
        #expect(exif.focalLength == 0.0)
    }

    @Test func numericProperties_handleNegativeValues() {
        let dict: NSDictionary = [
            kCGImagePropertyExifBrightnessValue as String: -2.5,
            kCGImagePropertyExifExposureBiasValue as String: -1.0
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.brightnessValue == -2.5)
        #expect(exif.exposureBiasValue == -1.0)
    }

    @Test func numericProperties_handleVeryLargeValues() {
        let dict: NSDictionary = [
            kCGImagePropertyExifPixelXDimension as String: 999999,
            kCGImagePropertyExifPixelYDimension as String: 999999,
            kCGImagePropertyExifFocalPlaneXResolution as String: 100000.0,
            kCGImagePropertyExifFocalPlaneYResolution as String: 100000.0
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.pixelXDimension == 999999)
        #expect(exif.pixelYDimension == 999999)
        #expect(exif.focalPlaneXResolution == 100000.0)
        #expect(exif.focalPlaneYResolution == 100000.0)
    }

    @Test func stringProperties_handleEmptyStrings() {
        let dict: NSDictionary = [
            kCGImagePropertyExifBodySerialNumber as String: "",
            kCGImagePropertyExifCameraOwnerName as String: "",
            kCGImagePropertyExifLensMake as String: "",
            kCGImagePropertyExifLensModel as String: "",
            kCGImagePropertyExifUserComment as String: ""
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.bodySerialNumber == "")
        #expect(exif.cameraOwnerName == "")
        #expect(exif.lensMake == "")
        #expect(exif.lensModel == "")
        #expect(exif.userComment == "")
    }

    @Test func stringProperties_handleSpecialCharacters() {
        let dict: NSDictionary = [
            kCGImagePropertyExifCameraOwnerName as String: "José García-Müller",
            kCGImagePropertyExifUserComment as String: "Testing 123 !@#$%^&*()",
            kCGImagePropertyExifLensModel as String: "Canon EF 24-70mm f/2.8L II USM"
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.cameraOwnerName == "José García-Müller")
        #expect(exif.userComment == "Testing 123 !@#$%^&*()")
        #expect(exif.lensModel == "Canon EF 24-70mm f/2.8L II USM")
    }

    @Test func stringProperties_handleUnicode() {
        let dict: NSDictionary = [
            kCGImagePropertyExifCameraOwnerName as String: "田中太郎",
            kCGImagePropertyExifUserComment as String: "🎉📷✨"
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.cameraOwnerName == "田中太郎")
        #expect(exif.userComment == "🎉📷✨")
    }

    @Test func intProperties_handleValidRanges() {
        let dict: NSDictionary = [
            kCGImagePropertyExifFlash as String: 0,
            kCGImagePropertyExifSceneType as String: 1,
            kCGImagePropertyExifFileSource as String: 3,
            kCGImagePropertyExifFocalLenIn35mmFilm as String: 50,
            kCGImagePropertyExifISOSpeed as String: 6400
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.flash == 0)
        #expect(exif.sceneType == 1)
        #expect(exif.fileSource == 3)
        #expect(exif.focalLenIn35mmFilm == 50)
        #expect(exif.isoSpeed == 6400)
    }

    @Test func dateTimeDigitized_independentFromDateTimeOriginal() throws {
        let dict: NSDictionary = [
            kCGImagePropertyExifDateTimeOriginal as String: "2025:01:01 10:00:00",
            kCGImagePropertyExifSubsecTimeOriginal as String: "100",
            kCGImagePropertyExifOffsetTimeOriginal as String: "+09:00",
            kCGImagePropertyExifDateTimeDigitized as String: "2025:01:02 11:00:00",
            kCGImagePropertyExifSubsecTimeDigitized as String: "200",
            kCGImagePropertyExifOffsetTimeDigitized as String: "-05:00"
        ]
        let exif = EXIF(rawValue: dict)
        
        let original = try #require(exif.dateTimeOriginal)
        let digitized = try #require(exif.dateTimeDigitized)
        
        #expect(original != digitized)
        #expect(exif.timeZoneOriginal != exif.timeZoneDigitized)
    }

    @Test(arguments: [(2, EXIF.ExposureProgram.normalProgram)])
    func exposureProgram_allKnownValues(rawValue: Int, expected: EXIF.ExposureProgram) {
        let dict: NSDictionary = [kCGImagePropertyExifExposureProgram as String: rawValue]
        #expect(EXIF(rawValue: dict).exposureProgram == expected)
    }

    @Test(arguments: [(2, EXIF.SensingMethod.oneChipColorArea)])
    func sensingMethod_allKnownValues(rawValue: Int, expected: EXIF.SensingMethod) {
        let dict: NSDictionary = [kCGImagePropertyExifSensingMethod as String: rawValue]
        #expect(EXIF(rawValue: dict).sensingMethod == expected)
    }

    @Test(arguments: [(0, EXIF.WhiteBalance.auto)])
    func whiteBalance_allKnownValues(rawValue: Int, expected: EXIF.WhiteBalance) {
        let dict: NSDictionary = [kCGImagePropertyExifWhiteBalance as String: rawValue]
        #expect(EXIF(rawValue: dict).whiteBalance == expected)
    }

    @Test(arguments: [(0, EXIF.SceneCaptureType.standard)])
    func sceneCaptureType_allKnownValues(rawValue: Int, expected: EXIF.SceneCaptureType) {
        let dict: NSDictionary = [kCGImagePropertyExifSceneCaptureType as String: rawValue]
        #expect(EXIF(rawValue: dict).sceneCaptureType == expected)
    }

    @Test(arguments: [(5, EXIF.MeteringMode.pattern)])
    func meteringMode_allKnownValues(rawValue: Int, expected: EXIF.MeteringMode) {
        let dict: NSDictionary = [kCGImagePropertyExifMeteringMode as String: rawValue]
        #expect(EXIF(rawValue: dict).meteringMode == expected)
    }

    @Test(arguments: [(0, EXIF.ExposureMode.auto)])
    func exposureMode_allKnownValues(rawValue: Int, expected: EXIF.ExposureMode) {
        let dict: NSDictionary = [kCGImagePropertyExifExposureMode as String: rawValue]
        #expect(EXIF(rawValue: dict).exposureMode == expected)
    }

    @Test func complexRealWorldData_parsesCorrectly() throws {
        // Simulate a comprehensive EXIF data set from a modern camera
        let dict: NSDictionary = [
            kCGImagePropertyExifApertureValue as String: 2.970854,
            kCGImagePropertyExifBrightnessValue as String: 4.5,
            kCGImagePropertyExifColorSpace as String: 1,
            kCGImagePropertyExifComponentsConfiguration as String: [1, 2, 3, 0],
            kCGImagePropertyExifDateTimeOriginal as String: "2026:02:13 15:30:45",
            kCGImagePropertyExifSubsecTimeOriginal as String: "123",
            kCGImagePropertyExifOffsetTimeOriginal as String: "-08:00",
            kCGImagePropertyExifExposureBiasValue as String: -0.33,
            kCGImagePropertyExifExposureMode as String: 0,
            kCGImagePropertyExifExposureProgram as String: 2,
            kCGImagePropertyExifExposureTime as String: 0.0125,
            kCGImagePropertyExifFNumber as String: 2.8,
            kCGImagePropertyExifFlash as String: 0,
            kCGImagePropertyExifFocalLength as String: 50.0,
            kCGImagePropertyExifFocalLenIn35mmFilm as String: 75,
            kCGImagePropertyExifISOSpeedRatings as String: [800],
            kCGImagePropertyExifLensMake as String: "Sony",
            kCGImagePropertyExifLensModel as String: "FE 50mm F1.8",
            kCGImagePropertyExifMeteringMode as String: 5,
            kCGImagePropertyExifPixelXDimension as String: 6000,
            kCGImagePropertyExifPixelYDimension as String: 4000,
            kCGImagePropertyExifSceneCaptureType as String: 0,
            kCGImagePropertyExifSensingMethod as String: 2,
            kCGImagePropertyExifWhiteBalance as String: 0
        ]
        let exif = EXIF(rawValue: dict)
        
        #expect(exif.fNumber == 2.8)
        #expect(exif.focalLength == 50.0)
        #expect(exif.isoSpeedRatings == [800])
        #expect(exif.lensModel == "FE 50mm F1.8")
        #expect(exif.pixelXDimension == 6000)
        #expect(exif.dateTimeOriginal != nil)
    }
}

