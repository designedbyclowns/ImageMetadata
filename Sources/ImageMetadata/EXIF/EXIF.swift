import Foundation
import ImageIO

/// Metadata defined by the [Exif Exchangeable Image File Format](https://www.loc.gov/preservation/digital/formats/fdd/fdd000146.shtml).
public struct EXIF: Metadata {

    /// The aperture value.
    public var apertureValue: Double? {
        rawValue[kCGImagePropertyExifApertureValue] as? Double
    }
    
    /// A string with the serial number of the camera.
    public var bodySerialNumber: String? {
        rawValue[kCGImagePropertyExifBodySerialNumber] as? String
    }
    
    /// The brightness value.
    public var brightnessValue: Double? {
        rawValue[kCGImagePropertyExifBrightnessValue] as? Double
     }
    
    /// A string with the name of the camera’s owner.
    public var cameraOwnerName: String? {
        rawValue[kCGImagePropertyExifCameraOwnerName] as? String
    }
    
    /// The color filter array (CFA) pattern, which is the geometric pattern of
    /// the image sensor for a 1-chip color sensor area.
    public var cfaPattern: Int? {
        rawValue[kCGImagePropertyExifCFAPattern] as? Int
    }
    
    /// The color space.
    public var colorSpace: Int? {
        rawValue[kCGImagePropertyExifColorSpace] as? Int
    }
    
    /// The components configuration for compressed data.
    ///
    /// For compressed data, specifies that the channels of each component
    /// are arranged in increasing numeric order (from first component to the fourth).
    public var componentsConfiguration: [Int]? {
        rawValue[kCGImagePropertyExifComponentsConfiguration] as? [Int]
    }
    // FIXME: Undefined
    
    /// Indicates whether the recorded image is a composite image or not.
    public var compositeImage: Int? {
        rawValue[kCGImagePropertyExifCompositeImage] as? Int
    }
    
    /// The bits per pixel of the compression mode.
    public var compressedBitsPerPixel: Double? {
        rawValue[kCGImagePropertyExifCompressedBitsPerPixel] as? Double
    }
    
    /// The contrast setting.
    public var contrast: EXIF.Contrast? {
        guard let value = rawValue[kCGImagePropertyExifContrast] as? Int else { return nil }
        return EXIF.Contrast(rawValue: value)
    }
    
    /// Special rendering performed on the image data.
    ///
    /// When special processing is performed, the reader is expected
    /// to disable or minimize any further processing.
    public var customRendered: EXIF.CustomRendered? {
        guard let value = rawValue[kCGImagePropertyExifCustomRendered] as? Int else { return nil }
        return EXIF.CustomRendered(rawValue: value)
    }
    
    /// The date the image was stored as digital data.
    public var dateTimeDigitized: Date? {
        guard let dateString = rawValue[kCGImagePropertyExifDateTimeDigitized] as? String else { return nil }
        return Self.dateFormatter.date(from: dateString)
    }
    
    /// The date the original image data was generated.
    ///
    /// For a digital still camera the date and time the picture was taken are recorded.
    public var dateTimeOriginal: Date? {
        guard let dateString = rawValue[kCGImagePropertyExifDateTimeOriginal] as? String else { return nil }
        return Self.dateFormatter.date(from: dateString)
    }
    
    /// For a particular camera mode, indicates the conditions for taking the picture.
    public var deviceSettingDescription: String? {
        rawValue[kCGImagePropertyExifDeviceSettingDescription] as? String
    }
    
    /// The digital zoom ratio.
    public var digitalZoomRatio: Double? {
        rawValue[kCGImagePropertyExifDigitalZoomRatio] as? Double
    }
    
    /// The exposure bias value.
    public var exposureBiasValue: Double? {
        rawValue[kCGImagePropertyExifExposureBiasValue] as? Double
    }
    
    /// The selected exposure index.
    public var exposureIndex: Double? {
        rawValue[kCGImagePropertyExifExposureIndex] as? Double
    }
    
    /// The ``EXIF/ExposureMode`` mode setting.
    ///
    ///  In auto-bracketing mode, the camera shoots a series of frames of the same scene at different exposure settings.
    public var exposureMode: EXIF.ExposureMode? {
        guard let value = rawValue[kCGImagePropertyExifExposureMode] as? Int else { return nil }
        return EXIF.ExposureMode(rawValue: value)
    }
    
    /// The ``EXIF/ExposureProgram``.
    ///
    /// The program used by the camera to set exposure when the picture is taken.
    public var exposureProgram: EXIF.ExposureProgram? {
        guard let value = rawValue[kCGImagePropertyExifExposureProgram] as? Int else { return nil }
        return EXIF.ExposureProgram(rawValue: value)
    }
    
    /// The exposure time, in seconds.
    public var exposureTime: Double? {
        rawValue[kCGImagePropertyExifExposureTime] as? Double
    }
    
    
    /// The image source.
    ///
    /// If a DSC recorded the image, this tag value of this tag always
    /// be set to 3, indicating that the image was recorded on a DSC.
    public var fileSource: Int? {
        rawValue[kCGImagePropertyExifFileSource] as? Int
    }
    
    /// The strobe energy when the image was captured, in beam candle power seconds.
    public var flashEnergy: Double? {
        rawValue[kCGImagePropertyExifFlashEnergy] as? Double
    }
    
    /// The flash status when the image was shot.
    public var flash: Int? {
        rawValue[kCGImagePropertyExifFlash] as? Int
    }    // FIXME: Needs to be parsed from return values into a specific type.
    
       
    /// The Flashpix format version supported by a FPXR file.
    public var flashPixVersion: String? {
        guard let components = rawValue[kCGImagePropertyExifFlashPixVersion] as? [CustomStringConvertible] else { return nil }
        return components
            .map { String(describing: $0) }
            .joined(separator: ".")
    }
    
    /// The F-number.
    public var fNumber: Double? {
        rawValue[kCGImagePropertyExifFNumber] as? Double
    }
    
    /// The focal length.
    public var focalLength: Double? {
        rawValue[kCGImagePropertyExifFocalLength] as? Double
    }
    /// The equivalent focal length in 35 mm film.
    ///
    /// A value of 0 means the focal length is unknown.
    ///
    /// > Note: This tag differs from the ``focalLength`` property.
    public var focalLenIn35mmFilm: Int? {
        rawValue[kCGImagePropertyExifFocalLenIn35mmFilm] as? Int
    }
    
    /// The unit of measurement for the focal plane x and y resolutions.
    public var focalPlaneResolutionUnit: Int? {
        rawValue[kCGImagePropertyExifFocalPlaneResolutionUnit] as? Int
    }
    
    /// The number of image-width pixels (x-axis) per focal plane resolution unit.
    public var focalPlaneXResolution: Double? {
        rawValue[kCGImagePropertyExifFocalPlaneXResolution] as? Double
    }
    
    /// The number of image-height pixels (y-axis) per focal plane resolution unit.
    public var focalPlaneYResolution: Double? {
        rawValue[kCGImagePropertyExifFocalPlaneYResolution] as? Double
    }
    
    /// The gain adjustment setting.
    public var gainControl: Int? {
        rawValue[kCGImagePropertyExifGainControl] as? Int
    }
    
    /// The gamma setting.
    public var gamma: Double? {
        rawValue[kCGImagePropertyExifGamma] as? Double
    }
    
    /// The unique ID of the image.
    public var imageUniqueID: String? {
        rawValue[kCGImagePropertyExifImageUniqueID] as? String
    }
    
    /// The ISO speed setting used to capture the image.
    public var isoSpeed: Int? {
        rawValue[kCGImagePropertyExifISOSpeed] as? Int
    }
    
    /// The ISO speed latitude yyy value.
    public var isoSpeedLatitudeYYY: Int? {
        rawValue[kCGImagePropertyExifISOSpeedLatitudeyyy] as? Int
    }
    
    /// The ISO speed latitude zzz value.
    public var isoSpeedLatitudeZZZ: Int? {
        rawValue[kCGImagePropertyExifISOSpeedLatitudezzz] as? Int
    }
    
    /// The ISO speed ratings.
    public var isoSpeedRatings: [Int]? {
        rawValue[kCGImagePropertyExifISOSpeedRatings] as? [Int]
    }
    
    /// A string with the name of the lens manufacturer.
    public var lensMake: String? {
        rawValue[kCGImagePropertyExifLensMake] as? String
    }
    
    /// The specification information for the camera lens.
    ///
    /// This tag notes minimum focal length, maximum focal length, minimum F number
    ///  in the minimum focal length, and minimum F number in the maximum focal length,
    ///  which are specification information for the lens that was used in photography.
    ///
    ///  When the minimum F number is unknown, the notation is 0/0.
    public var lensSpecification: String? {
        rawValue[kCGImagePropertyExifLensSpecification] as? String
    }
    
    /// The kind of light source.
    public var lightSource: EXIF.LightSource? {
        guard let value = rawValue[kCGImagePropertyExifLightSource] as? Int else { return nil }
        return EXIF.LightSource(rawValue: value)
    }
    
    /// Information specified by the camera manufacturer.
    ///
    /// A tag for manufacturers of Exif writers to record any desired information.
    /// The contents are up to the manufacturer, but this tag should not be used
    /// for any other than its intended purpose.
    public var makerNote: String? {
        rawValue[kCGImagePropertyExifMakerNote] as? String
    }
    
    /// The maximum aperture value.
    public var maxApertureValue: Double? {
        rawValue[kCGImagePropertyExifMaxApertureValue] as? Double
    }
    
    /// The ``EXIF/MeteringMode``.
    public var meteringMode: EXIF.MeteringMode? {
        guard let value = rawValue[kCGImagePropertyExifMeteringMode] as? Int else { return nil }
        return EXIF.MeteringMode(rawValue: value)
    }
    
    /// The opto-electric conversion function (OECF) that defines the relationship
    ///  between the optical input of the camera and the resulting image.
    ///
    ///  Specified in ISO 14524.
    public var oecf: String? {
        rawValue[kCGImagePropertyExifOECF] as? String
    }
    // FIXME: Undefined ^^^
    
    /// Time difference from Universal Time Coordinated (UTC) including
    /// daylight saving time of `DateTime` tag.
    public var offsetTime: String? {
        rawValue[kCGImagePropertyExifOffsetTime] as? String
    }
    
    /// Time difference from Universal Time Coordinated (UTC) including
    /// daylight saving time of ``dateTimeDigitized`` tag.
    public var offsetTimeDigitized: String? {
        rawValue[kCGImagePropertyExifOffsetTimeDigitized] as? String
    }
    
    /// Time difference from Universal Time Coordinated (UTC) including
    /// daylight saving time of ``dateTimeOriginal`` tag.
    public var offsetTimeOriginal: String? {
        rawValue[kCGImagePropertyExifOffsetTimeOriginal] as? String
    }
    
    /// The x dimension of a pixel.
    public var pixelXDimension: Int? {
        rawValue[kCGImagePropertyExifPixelXDimension] as? Int
    }
    
    /// The y dimension of a pixel.
    public var pixelYDimension: Int? {
        rawValue[kCGImagePropertyExifPixelYDimension] as? Int
    }
    
    /// The recommended exposure index.
    public var recommendedExposureIndex: Int? {
        rawValue[kCGImagePropertyExifRecommendedExposureIndex] as? Int
     }
    
    /// A sound file related to the image.
    public var relatedSoundFile: String? {
        rawValue[kCGImagePropertyExifRelatedSoundFile] as? String
     }
    
    
    /// The ``EXIF/Saturation`` setting.
    public var saturation: EXIF.Saturation? {
        guard let value = rawValue[kCGImagePropertyExifSaturation] as? Int else { return nil }
        return EXIF.Saturation(rawValue: value)
    }
    
    /// The ``EXIF/SceneCaptureType``; for example, standard, landscape, portrait, or night.
    public var sceneCaptureType: EXIF.SceneCaptureType? {
        guard let value = rawValue[kCGImagePropertyExifSceneCaptureType] as? Int else { return nil }
        return EXIF.SceneCaptureType(rawValue: value)
    }
    
    /// The scene type.
    ///
    ///  If a DSC recorded the image, this tag value shall always be
    ///   set to 1, indicating that the image was directly photographed.
    public var sceneType: Int? {
        rawValue[kCGImagePropertyExifSceneType] as? Int
    }
    
    /// The ``EXIF/SensingMethod`` of the camera or input device.
    public var sensingMethod: EXIF.SensingMethod? {
        guard let value = rawValue[kCGImagePropertyExifSensingMethod] as? Int else { return nil }
        return EXIF.SensingMethod(rawValue: value)
    }
    
    /// The type of sensitivity data stored for the image.
    public var sensitivityType: Double? {
        rawValue[kCGImagePropertyExifSensitivityType] as? Double
    }
    
   
    /// The ``EXIF/Sharpness`` setting.
    public var sharpness: EXIF.Sharpness? {
        guard let value = rawValue[kCGImagePropertyExifSharpness] as? Int else { return nil }
        return EXIF.Sharpness(rawValue: value)
    }
    
    /// The shutter speed value.
    public var shutterSpeedValue: Double? {
        rawValue[kCGImagePropertyExifShutterSpeedValue] as? Double
     }
    
    /// The exposure times for composite images.
    public var sourceExposureTimesOfCompositeImage: String? {
        rawValue[kCGImagePropertyExifSourceExposureTimesOfCompositeImage] as? String
     }
    
    /// The number of images that make up a composite image.
    public var sourceImageNumberOfCompositeImage: Int? {
        rawValue[kCGImagePropertyExifSourceImageNumberOfCompositeImage] as? Int
     }
    
    /// The spatial frequency table and spatial frequency response values in
    /// the width, height, and diagonal directions.
    public var spatialFrequencyResponse: String? {
        rawValue[kCGImagePropertyExifSpatialFrequencyResponse] as? String
     }
    // FIXME: This type is undefined
    
    /// The spectral sensitivity of each channel.
    public var spectralSensitivity: String? {
        rawValue[kCGImagePropertyExifSpectralSensitivity] as? String
    }
    
    /// The sensitivity data for the image.
    public var standardOutputSensitivity: Double? {
        rawValue[kCGImagePropertyExifStandardOutputSensitivity] as? Double
     }
    
    /// The subject area.
    ///
    /// The location and area of the main subject in the overall scene.
    public var subjectArea: [Int]? {
        rawValue[kCGImagePropertyExifSubjectArea] as? [Int]
    }
    // FIXME: This should be converted to a custom type that can represent a point (location), circular area, or rectangular area.
    
    /// The distance to the subject.
    public var subjectDistance: Double? {
        rawValue[kCGImagePropertyExifSubjectDistance] as? Double
    }
    
    /// The distance to the subject as an ``EXIF/SubjectDistanceRange``.
    public var subjectDistanceRange: EXIF.SubjectDistanceRange? {
        guard let value = rawValue[kCGImagePropertyExifSubjectDistRange] as? Int else { return nil }
        return EXIF.SubjectDistanceRange(rawValue: value)
    }
    
    /// The location of the image’s primary subject.
    public var subjectLocation: Int? {
        rawValue[kCGImagePropertyExifSubjectLocation] as? Int
     }
    // FIXME: Should maybe be an (Init, Int)?
    
    /// The fraction of seconds for the date and time tag.
    public var subsecTime: String? {
        rawValue[kCGImagePropertyExifSubsecTime] as? String
     }
    
    /// The fraction of seconds for the digitized date and time tag.
    public var subsecTimeDigitized: String? {
        rawValue[kCGImagePropertyExifSubsecTimeDigitized] as? String
     }
    
    /// The fraction of seconds for the original date and time tag.
    public var subsecTimeOriginal: String? {
        rawValue[kCGImagePropertyExifSubsecTimeOriginal] as? String
     }
    
    /// A user comment.
    ///
    /// A tag for EXIF users to write keywords or comments on the image
    /// besides those in `ImageDescription`, and without the character
    /// code limitations of the `ImageDescription` tag.
    public var userComment: String? {
        rawValue[kCGImagePropertyExifUserComment] as? String
     }
    
    /// The EXIF version.
    public var version: String? {
        guard let components = rawValue[kCGImagePropertyExifVersion] as? [CustomStringConvertible] else { return nil }
        return components
            .map { String(describing: $0) }
            .joined(separator: ".")
     }
    
    /// The white balance mode.
    public var whiteBalance: EXIF.WhiteBalance? {
        guard let value = rawValue[kCGImagePropertyExifWhiteBalance] as? Int else { return nil }
        return EXIF.WhiteBalance(rawValue: value)
    }
    
    // MARK: - RawRepresentable
    
    public typealias RawValue = NSDictionary
    
    public init(rawValue: NSDictionary) {
        self.rawValue = rawValue
    }
    
    public let rawValue: NSDictionary
    
    // MARK: - Formatters
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return formatter
    }()
}

// MARK: - Auxiliary rawValue

extension EXIF {
    
    public var auxiliaryProperties: NSDictionary? {
        rawValue[kCGImagePropertyExifAuxDictionary] as? NSDictionary
    }
    /// Firmware information.
    public var firmware: String? {
        auxiliaryProperties?[kCGImagePropertyExifAuxFirmware] as? String
     }
    
    /// Flash compensation.
    public var flashCompensation: String? {
        auxiliaryProperties?[kCGImagePropertyExifAuxFlashCompensation] as? String
     }
    
    /// The image number.
    public var imageNumber: String? {
        auxiliaryProperties?[kCGImagePropertyExifAuxImageNumber] as? String
     }
    
    /// The lens ID.
    public var lensID: String? {
        auxiliaryProperties?[kCGImagePropertyExifAuxLensID] as? String
     }
    
    /// A string with the lens model information.
    public var lensModel: String? {
        auxiliaryProperties?[kCGImagePropertyExifAuxLensModel] as? String ?? rawValue[kCGImagePropertyExifLensModel] as? String
     }
    /// A string with the lens’s serial number.
    public var lensSerialNumber: String? {
        auxiliaryProperties?[kCGImagePropertyExifAuxLensSerialNumber] as? String ?? rawValue[kCGImagePropertyExifLensSerialNumber] as? String
     }
    
    /// Lens information.
    public var lensInfo: String? {
        auxiliaryProperties?[kCGImagePropertyExifAuxLensInfo] as? String
    }
    
    /// The owner name.
    public var ownerName: String? {
        auxiliaryProperties?[kCGImagePropertyExifAuxOwnerName] as? String
     }
    
    /// The serial number.
    public var serialNumber: String? {
        auxiliaryProperties?[kCGImagePropertyExifAuxSerialNumber] as? String
     }
}

extension EXIF: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case apertureValue
        case bodySerialNumber
        case brightnessValue
        case cameraOwnerName
        case cfaPattern
        case colorSpace
        case componentsConfiguration
        case compositeImage
        case compressedBitsPerPixel
        case contrast
        case customRendered
        case dateTimeDigitized
        case dateTimeOriginal
        case deviceSettingDescription
        case digitalZoomRatio
        case exposureBiasValue
        case exposureIndex
        case exposureMode
        case exposureProgram
        case exposureTime
        case fileSource
        case firmware
        case flash
        case flashCompensation
        case flashEnergy
        case flashPixVersion
        case fNumber
        case focalLength
        case focalLenIn35mmFilm
        case focalPlaneResolutionUnit
        case focalPlaneXResolution
        case focalPlaneYResolution
        case gainControl
        case gamma
        case imageNumber
        case imageUniqueID
        case isoSpeed
        case isoSpeedLatitudeYYY
        case isoSpeedLatitudeZZZ
        case isoSpeedRatings
        case lensID
        case lensInfo
        case lensMake
        case lensModel
        case lensSerialNumber
        case lensSpecification
        case lightSource
        case makerNote
        case maxApertureValue
        case meteringMode
        case oecf
        case offsetTime
        case offsetTimeDigitized
        case offsetTimeOriginal
        case ownerName
        case pixelXDimension
        case pixelYDimension
        case recommendedExposureIndex
        case relatedSoundFile
        case saturation
        case sceneCaptureType
        case sceneType
        case sensingMethod
        case sensitivityType
        case serialNumber
        case sharpness
        case shutterSpeedValue
        case sourceExposureTimesOfCompositeImage
        case sourceImageNumberOfCompositeImage
        case spatialFrequencyResponse
        case spectralSensitivity
        case standardOutputSensitivity
        case subjectArea
        case subjectDistance
        case subjectDistanceRange
        case subjectLocation
        case subsecTime
        case subsecTimeDigitized
        case subsecTimeOriginal
        case userComment
        case version
        case whiteBalance
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(apertureValue, forKey: .apertureValue)
        try container.encodeIfPresent(bodySerialNumber, forKey: .bodySerialNumber)
        try container.encodeIfPresent(brightnessValue, forKey: .brightnessValue)
        try container.encodeIfPresent(cameraOwnerName, forKey: .cameraOwnerName)
        try container.encodeIfPresent(cfaPattern, forKey: .cfaPattern)
        try container.encodeIfPresent(colorSpace, forKey: .colorSpace)
        try container.encodeIfPresent(componentsConfiguration, forKey: .componentsConfiguration)
        try container.encodeIfPresent(compositeImage, forKey: .compositeImage)
        try container.encodeIfPresent(compressedBitsPerPixel, forKey: .compressedBitsPerPixel)
        try container.encodeIfPresent(contrast?.description, forKey: .contrast)
        try container.encodeIfPresent(customRendered?.description, forKey: .customRendered)
        try container.encodeIfPresent(dateTimeDigitized, forKey: .dateTimeDigitized)
        try container.encodeIfPresent(dateTimeOriginal, forKey: .dateTimeOriginal)
        try container.encodeIfPresent(deviceSettingDescription, forKey: .deviceSettingDescription)
        try container.encodeIfPresent(digitalZoomRatio, forKey: .digitalZoomRatio)
        try container.encodeIfPresent(exposureBiasValue, forKey: .exposureBiasValue)
        try container.encodeIfPresent(exposureIndex, forKey: .exposureIndex)
        try container.encodeIfPresent(exposureMode?.description, forKey: .exposureMode)
        try container.encodeIfPresent(exposureProgram?.description, forKey: .exposureProgram)
        try container.encodeIfPresent(exposureTime, forKey: .exposureTime)
        try container.encodeIfPresent(fileSource, forKey: .fileSource)
        try container.encodeIfPresent(firmware, forKey: .firmware)
        try container.encodeIfPresent(flash, forKey: .flash)
        try container.encodeIfPresent(flashCompensation, forKey: .flashCompensation)
        try container.encodeIfPresent(flashEnergy, forKey: .flashEnergy)
        try container.encodeIfPresent(flashPixVersion, forKey: .flashPixVersion)
        try container.encodeIfPresent(fNumber, forKey: .fNumber)
        try container.encodeIfPresent(focalLength, forKey: .focalLength)
        try container.encodeIfPresent(focalLenIn35mmFilm, forKey: .focalLenIn35mmFilm)
        try container.encodeIfPresent(focalPlaneResolutionUnit, forKey: .focalPlaneResolutionUnit)
        try container.encodeIfPresent(focalPlaneXResolution, forKey: .focalPlaneXResolution)
        try container.encodeIfPresent(focalPlaneYResolution, forKey: .focalPlaneYResolution)
        try container.encodeIfPresent(gainControl, forKey: .gainControl)
        try container.encodeIfPresent(gamma, forKey: .gamma)
        try container.encodeIfPresent(imageNumber, forKey: .imageNumber)
        try container.encodeIfPresent(imageUniqueID, forKey: .imageUniqueID)
        try container.encodeIfPresent(isoSpeed, forKey: .isoSpeed)
        try container.encodeIfPresent(isoSpeedLatitudeYYY, forKey: .isoSpeedLatitudeYYY)
        try container.encodeIfPresent(isoSpeedLatitudeZZZ, forKey: .isoSpeedLatitudeZZZ)
        try container.encodeIfPresent(isoSpeedRatings, forKey: .isoSpeedRatings)
        try container.encodeIfPresent(lensID, forKey: .lensID)
        try container.encodeIfPresent(lensInfo, forKey: .lensInfo)
        try container.encodeIfPresent(lensMake, forKey: .lensMake)
        try container.encodeIfPresent(lensModel, forKey: .lensModel)
        try container.encodeIfPresent(lensSerialNumber, forKey: .lensSerialNumber)
        try container.encodeIfPresent(lensSpecification, forKey: .lensSpecification)
        try container.encodeIfPresent(lightSource?.description, forKey: .lightSource)
        try container.encodeIfPresent(makerNote, forKey: .makerNote)
        try container.encodeIfPresent(maxApertureValue, forKey: .maxApertureValue)
        try container.encodeIfPresent(meteringMode?.description, forKey: .meteringMode)
        try container.encodeIfPresent(oecf, forKey: .oecf)
        try container.encodeIfPresent(offsetTime, forKey: .offsetTime)
        try container.encodeIfPresent(offsetTimeDigitized, forKey: .offsetTimeDigitized)
        try container.encodeIfPresent(offsetTimeOriginal, forKey: .offsetTimeOriginal)
        try container.encodeIfPresent(ownerName, forKey: .ownerName)
        try container.encodeIfPresent(pixelXDimension, forKey: .pixelXDimension)
        try container.encodeIfPresent(pixelYDimension, forKey: .pixelYDimension)
        try container.encodeIfPresent(recommendedExposureIndex, forKey: .recommendedExposureIndex)
        try container.encodeIfPresent(relatedSoundFile, forKey: .relatedSoundFile)
        try container.encodeIfPresent(saturation?.description, forKey: .saturation)
        try container.encodeIfPresent(sceneCaptureType?.description, forKey: .sceneCaptureType)
        try container.encodeIfPresent(sceneType, forKey: .sceneType)
        try container.encodeIfPresent(sensingMethod?.description, forKey: .sensingMethod)
        try container.encodeIfPresent(sensitivityType, forKey: .sensitivityType)
        try container.encodeIfPresent(serialNumber, forKey: .serialNumber)
        try container.encodeIfPresent(sharpness?.description, forKey: .sharpness)
        try container.encodeIfPresent(shutterSpeedValue, forKey: .shutterSpeedValue)
        try container.encodeIfPresent(sourceExposureTimesOfCompositeImage, forKey: .sourceExposureTimesOfCompositeImage)
        try container.encodeIfPresent(sourceImageNumberOfCompositeImage, forKey: .sourceImageNumberOfCompositeImage)
        try container.encodeIfPresent(spatialFrequencyResponse, forKey: .spatialFrequencyResponse)
        try container.encodeIfPresent(spectralSensitivity, forKey: .spectralSensitivity)
        try container.encodeIfPresent(standardOutputSensitivity, forKey: .standardOutputSensitivity)
        try container.encodeIfPresent(subjectArea, forKey: .subjectArea)
        try container.encodeIfPresent(subjectDistance, forKey: .subjectDistance)
        try container.encodeIfPresent(subjectDistanceRange?.description, forKey: .subjectDistanceRange)
        try container.encodeIfPresent(subjectLocation, forKey: .subjectLocation)
        try container.encodeIfPresent(subsecTime, forKey: .subsecTime)
        try container.encodeIfPresent(subsecTimeDigitized, forKey: .subsecTimeDigitized)
        try container.encodeIfPresent(subsecTimeOriginal, forKey: .subsecTimeOriginal)
        try container.encodeIfPresent(userComment, forKey: .userComment)
        try container.encodeIfPresent(version, forKey: .version)
        try container.encodeIfPresent(whiteBalance?.description, forKey: .whiteBalance)
    }
}
