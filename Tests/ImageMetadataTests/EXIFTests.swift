import Testing
import Foundation
import Numerics
@testable import ImageMetadata

struct EXIFTests {
    
    let exif: EXIF
    
    init() throws {
        let url = try #require(Bundle.module.url(forResource: "exif", withExtension: "jpg"))
        let imageFile = try ImageFile(url: url)
        let image = try ImageMetadata(imageFile: imageFile)
        self.exif = try #require(image.exif)
    }
    
    @Test func apertureValue() throws {
        let apertureValue = try #require(exif.apertureValue)
        #expect(apertureValue.isApproximatelyEqual(to: 1.35614, absoluteTolerance: 0.00001))
    }
    
    @Test func bodySerialNumber() {
        #expect(exif.bodySerialNumber == nil)
    }
        
    @Test func brightnessValue() throws {
        let brightnessValue = try #require(exif.brightnessValue)
        #expect(brightnessValue.isApproximatelyEqual(to: 0.101368, absoluteTolerance: 0.00001))
    }
    
    @Test func cameraOwnerName() {
        #expect(exif.cameraOwnerName == nil)
    }
    
    @Test func cfaPattern() {
        #expect(exif.cfaPattern == nil)
    }
    
    @Test func colorSpace() {
        #expect(exif.colorSpace == 65535)
    }
    
    @Test func componentsConfiguration() {
        #expect(exif.componentsConfiguration == [1, 2, 3, 0])
    }
    
    @Test func compositeImage() {
        #expect(exif.compositeImage == 2)
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
       
    @Test func dateTimeOriginal() {
        #expect(exif.dateTimeOriginal == Date(timeIntervalSinceReferenceDate: 735232275.0))
    }
    
    @Test func dateTimeDigitized() {
        #expect(exif.dateTimeDigitized == Date(timeIntervalSinceReferenceDate: 735232275.0))
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
        #expect(shutterSpeedValue.isApproximatelyEqual(to: 5.32204, absoluteTolerance: 0.00001))
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
    
    @Test func userComment() {
        #expect(exif.userComment == nil)
    }
    
    @Test func version() {
        #expect(exif.version == "2.3.2")
    }
    
    @Test func whiteBalance() {
        #expect(exif.whiteBalance == .auto)
    }
}
