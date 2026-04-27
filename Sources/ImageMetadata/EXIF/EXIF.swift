public import Foundation
import ImageIO

/// Metadata defined by the [Exif Exchangeable Image File Format](https://www.loc.gov/preservation/digital/formats/fdd/fdd000146.shtml).
public struct EXIF: Metadata {
    /// The aperture value.
    public let apertureValue: Double?
    
    /// A string with the serial number of the camera.
    public let bodySerialNumber: String?
    
    /// The brightness value.
    public let brightnessValue: Double?
    
    /// A string with the name of the camera’s owner.
    public let cameraOwnerName: String?
    
    /// The color filter array (CFA) pattern, which is the geometric pattern of
    /// the image sensor for a 1-chip color sensor area.
    public let cfaPattern: Int?
    
    /// The color space.
    public let colorSpace: ColorSpace?
    
    /// The components configuration for compressed data.
    ///
    /// For compressed data, specifies that the channels of each component
    /// are arranged in increasing numeric order (from first component to the fourth).
    public let componentsConfiguration: [Int]?
    
    /// Indicates whether the recorded image is a composite image or not.
    public let compositeImage: CompositeImage?
    
    /// The bits per pixel of the compression mode.
    public let compressedBitsPerPixel: Double?
    
    /// The contrast setting.
    public let contrast: EXIF.Contrast?
    
    /// Special rendering performed on the image data.
    ///
    /// When special processing is performed, the reader is expected
    /// to disable or minimize any further processing.
    public let customRendered: EXIF.CustomRendered?
    
    /// The date the image was stored as digital data.
    public let dateTimeDigitized: Date?
    
    /// The date the original image data was generated.
    ///
    /// For a digital still camera the date and time the picture was taken are recorded.
    public let dateTimeOriginal: Date?
    
    /// For a particular camera mode, indicates the conditions for taking the picture.
    public let deviceSettingDescription: String?
    
    /// The digital zoom ratio.
    public let digitalZoomRatio: Double?
    
    /// The exposure bias value.
    public let exposureBiasValue: Double?
    
    /// The selected exposure index.
    public let exposureIndex: Double?
    
    /// The ``EXIF/ExposureMode`` mode setting.
    ///
    ///  In auto-bracketing mode, the camera shoots a series of frames of the same scene at different exposure settings.
    public let exposureMode: EXIF.ExposureMode?
    
    /// The ``EXIF/ExposureProgram``.
    ///
    /// The program used by the camera to set exposure when the picture is taken.
    public let exposureProgram: EXIF.ExposureProgram?
    
    /// The exposure time, in seconds.
    public let exposureTime: Double?
    
    /// The image source.
    ///
    /// If a DSC recorded the image, this tag value of this tag always
    /// be set to 3, indicating that the image was recorded on a DSC.
    public let fileSource: Int?
    
    /// Firmware information.
    public let firmware: String?
    
    /// The strobe energy when the image was captured, in beam candle power seconds.
    public let flash: Int?
    
    /// Flash compensation.
    public let flashCompensation: String?
    
    /// The Flashpix format version supported by a FPXR file.
    public let flashPixVersion: String?
    
    /// The strobe energy when the image was captured, in beam candle power seconds.
    public let flashEnergy: Double?
    
    /// The F-number.
    public let fNumber: Double?
    
    /// The focal length.
    public let focalLength: Double?
    
    /// The equivalent focal length in 35 mm film.
    ///
    /// A value of 0 means the focal length is unknown.
    ///
    /// > Note: This tag differs from the ``focalLength`` property.
    public let focalLenIn35mmFilm: Int?
    
    /// The unit of measurement for the focal plane x and y resolutions.
    public let focalPlaneResolutionUnit: Int?
    
    /// The number of image-width pixels (x-axis) per focal plane resolution unit.
    public let focalPlaneXResolution: Double?
    
    /// The number of image-height pixels (y-axis) per focal plane resolution unit.
    public let focalPlaneYResolution: Double?
    
    /// The gain adjustment setting.
    public let gainControl: Int?
    
    /// The gamma setting.
    public let gamma: Double?
    
    /// The unique ID of the image.
    public let imageNumber: String?
    
    /// The unique ID of the image.
    public let imageUniqueID: String?
    
    /// The ISO speed setting used to capture the image.
    public let isoSpeed: Int?
    
    /// The ISO speed latitude yyy value.
    public let isoSpeedLatitudeYYY: Int?
    
    /// The ISO speed latitude zzz value.
    public let isoSpeedLatitudeZZZ: Int?
    
    /// The ISO speed ratings.
    public let isoSpeedRatings: [Int]?
    
    /// A string with the lens ID.
    public let lensID: String?
    
    /// Lens information.
    public let lensInfo: String?
    
    /// A string with the lens manufacturer.
    public let lensMake: String?
    
    /// A string with the lens model information.
    public let lensModel: String?
    
    /// A string with the lens’s serial number.
    public let lensSerialNumber: String?
    
    /// The specification information for the camera lens.
    ///
    /// This tag notes minimum focal length, maximum focal length, minimum F number
    ///  in the minimum focal length, and minimum F number in the maximum focal length,
    ///  which are specification information for the lens that was used in photography.
    ///
    ///  When the minimum F number is unknown, the notation is 0/0.
    public let lensSpecification: String?
    
    /// The kind of light source.
    public let lightSource: EXIF.LightSource?
    
    /// Information specified by the camera manufacturer.
    ///
    /// A tag for manufacturers of Exif writers to record any desired information.
    /// The contents are up to the manufacturer, but this tag should not be used
    /// for any other than its intended purpose.
    public let makerNote: String?
    
    /// The maximum aperture value.
    public let maxApertureValue: Double?
    
    /// The ``EXIF/MeteringMode``.
    public let meteringMode: EXIF.MeteringMode?
    
    /// The opto-electric conversion function (OECF) that defines the relationship
    ///  between the optical input of the camera and the resulting image.
    ///
    ///  Specified in ISO 14524.
    public let oecf: String?
    
    /// The owner name.
    public let ownerName: String?
    
    /// Time difference from Universal Time Coordinated (UTC) including
    /// daylight saving time of `DateTime` tag.
    public let offsetTime: String?
    
    /// Time difference from Universal Time Coordinated (UTC) including
    /// daylight saving time of ``dateTimeDigitized`` tag.
    public let offsetTimeDigitized: String?
    
    /// Time difference from Universal Time Coordinated (UTC) including
    /// daylight saving time of ``dateTimeOriginal`` tag.
    public let offsetTimeOriginal: String?
    
    /// The x dimension of a pixel.
    public let pixelXDimension: Int?
    
    /// The y dimension of a pixel.
    public let pixelYDimension: Int?
    
    /// The recommended exposure index.
    public let recommendedExposureIndex: Int?
    
    /// A sound file related to the image.
    public let relatedSoundFile: String?
    
    /// The serial number.
    public let serialNumber: String?
    
    /// The ``EXIF/Saturation`` setting.
    public let saturation: EXIF.Saturation?
    
    /// The ``EXIF/SceneCaptureType``; for example, standard, landscape, portrait, or night.
    public let sceneCaptureType: EXIF.SceneCaptureType?
    
    /// The scene type.
    ///
    ///  If a DSC recorded the image, this tag value shall always be
    ///   set to 1, indicating that the image was directly photographed.
    public let sceneType: Int?
    
    /// The ``EXIF/SensingMethod`` of the camera or input device.
    public let sensingMethod: EXIF.SensingMethod?
    
    /// The type of sensitivity data stored for the image.
    public let sensitivityType: Double?
    
    /// The ``EXIF/Sharpness`` setting.
    public let sharpness: EXIF.Sharpness?
    
    /// The shutter speed value.
    public let shutterSpeedValue: Double?
    
    /// The exposure times for composite images.
    public let sourceExposureTimesOfCompositeImage: String?
    
    /// The number of images that make up a composite image.
    public let sourceImageNumberOfCompositeImage: Int?
    
    /// The spatial frequency table and spatial frequency response values in
    /// the width, height, and diagonal directions.
    public let spatialFrequencyResponse: String?
    
    /// The spectral sensitivity of each channel.
    public let spectralSensitivity: String?
    
    /// The sensitivity data for the image.
    public let standardOutputSensitivity: Double?
    
    /// The subject area.
    ///
    /// The location and area of the main subject in the overall scene.
    public let subjectArea: [Int]?
    
    /// The distance to the subject.
    public let subjectDistance: Double?
    
    /// The distance to the subject as an ``EXIF/SubjectDistanceRange``.
    public let subjectDistanceRange: EXIF.SubjectDistanceRange?
    
    /// The location of the image’s primary subject.
    public let subjectLocation: Int?
    
    /// The fraction of seconds for the date and time tag.
    public let subsecTime: String?
    
    /// The fraction of seconds for the digitized date and time tag.
    public let subsecTimeDigitized: String?
    
    /// The fraction of seconds for the original date and time tag.
    public let subsecTimeOriginal: String?
    
    /// The time zone.
    public let timeZone: TimeZone?
    
    /// The time zone of the digitized date.
    public let timeZoneDigitized: TimeZone?
    
    /// The time zone of the original date.
    public let timeZoneOriginal: TimeZone?
    
    /// A user comment.
    ///
    /// A tag for EXIF users to write keywords or comments on the image
    /// besides those in `ImageDescription`, and without the character
    /// code limitations of the `ImageDescription` tag.
    public let userComment: String?
    
    /// The EXIF version.
    public let version: String?
    
    /// The white balance mode.
    public let whiteBalance: EXIF.WhiteBalance?
    
    public init(rawValue: NSDictionary, aux: NSDictionary? = nil) {
        self.apertureValue = rawValue[kCGImagePropertyExifApertureValue] as? Double
        self.bodySerialNumber = rawValue[kCGImagePropertyExifBodySerialNumber] as? String
        self.brightnessValue = rawValue[kCGImagePropertyExifBrightnessValue] as? Double
        self.cameraOwnerName = rawValue[kCGImagePropertyExifCameraOwnerName] as? String
        self.cfaPattern = rawValue[kCGImagePropertyExifCFAPattern] as? Int
        
        if let v = rawValue[kCGImagePropertyExifColorSpace] as? Int {
            self.colorSpace = ColorSpace(rawValue: v)
        } else {
            self.colorSpace = nil
        }
        
        self.componentsConfiguration = rawValue[kCGImagePropertyExifComponentsConfiguration] as? [Int]

        self.compositeImage = (rawValue[kCGImagePropertyExifCompositeImage] as? Int)
            .map({ CompositeImage(rawValue: $0) }) ?? nil
        
        self.compressedBitsPerPixel = rawValue[kCGImagePropertyExifCompressedBitsPerPixel] as? Double
        
        self.contrast = (rawValue[kCGImagePropertyExifContrast] as? Int)
            .map({ EXIF.Contrast(rawValue: $0) }) ?? nil
        
        self.customRendered = (rawValue[kCGImagePropertyExifCustomRendered] as? Int)
            .map({ EXIF.CustomRendered(rawValue: $0) }) ?? nil
        
        // Date digitized
        
        let offsetTimeDigitized = rawValue[kCGImagePropertyExifOffsetTimeDigitized] as? String
        self.offsetTimeDigitized = offsetTimeDigitized
        
        let timeZoneDigitized = Self.timeZone(forOffset: offsetTimeDigitized)
        self.timeZoneDigitized = timeZoneDigitized
        
        let subsecTimeDigitized = rawValue[kCGImagePropertyExifSubsecTimeDigitized] as? String
        self.subsecTimeDigitized = subsecTimeDigitized
        
        self.dateTimeDigitized = try? Self.parse(
            dateTime: rawValue[kCGImagePropertyExifDateTimeDigitized] as? String,
            subsec: subsecTimeDigitized,
            timeZone: timeZoneDigitized
        )
        
        // Original date
        
        let offsetTimeOriginal = rawValue[kCGImagePropertyExifOffsetTimeOriginal] as? String
        self.offsetTimeOriginal = offsetTimeOriginal
        
        let timeZoneOriginal = Self.timeZone(forOffset: offsetTimeOriginal)
        self.timeZoneOriginal = timeZoneOriginal
        
        let subsecTimeOriginal = rawValue[kCGImagePropertyExifSubsecTimeOriginal] as? String
        self.subsecTimeOriginal = subsecTimeOriginal
        
        self.dateTimeOriginal = try? Self.parse(
            dateTime: rawValue[kCGImagePropertyExifDateTimeOriginal] as? String,
            subsec: subsecTimeOriginal,
            timeZone: timeZoneOriginal
        )
        
        self.deviceSettingDescription = rawValue[kCGImagePropertyExifDeviceSettingDescription] as? String
        self.digitalZoomRatio = rawValue[kCGImagePropertyExifDigitalZoomRatio] as? Double
        self.exposureBiasValue = rawValue[kCGImagePropertyExifExposureBiasValue] as? Double
        self.exposureIndex = rawValue[kCGImagePropertyExifExposureIndex] as? Double
        
        self.exposureMode = (rawValue[kCGImagePropertyExifExposureMode] as? Int)
            .map({ EXIF.ExposureMode(rawValue: $0) }) ?? nil
        
        self.exposureProgram = (rawValue[kCGImagePropertyExifExposureProgram] as? Int)
            .map({ EXIF.ExposureProgram(rawValue: $0) }) ?? nil
        
        self.exposureTime = rawValue[kCGImagePropertyExifExposureTime] as? Double
        self.fileSource = rawValue[kCGImagePropertyExifFileSource] as? Int
        self.flashEnergy = rawValue[kCGImagePropertyExifFlashEnergy] as? Double
        self.flash = rawValue[kCGImagePropertyExifFlash] as? Int
        
        if let components = rawValue[kCGImagePropertyExifFlashPixVersion] as? [CustomStringConvertible] {
            self.flashPixVersion = components.map({ String(describing: $0) }).joined(separator: ".")
        } else {
            self.flashPixVersion = nil
        }
        
        self.fNumber = rawValue[kCGImagePropertyExifFNumber] as? Double
        self.focalLength = rawValue[kCGImagePropertyExifFocalLength] as? Double
        self.focalLenIn35mmFilm = rawValue[kCGImagePropertyExifFocalLenIn35mmFilm] as? Int
        self.focalPlaneResolutionUnit = rawValue[kCGImagePropertyExifFocalPlaneResolutionUnit] as? Int
        self.focalPlaneXResolution = rawValue[kCGImagePropertyExifFocalPlaneXResolution] as? Double
        self.focalPlaneYResolution = rawValue[kCGImagePropertyExifFocalPlaneYResolution] as? Double
        self.gainControl = rawValue[kCGImagePropertyExifGainControl] as? Int
        self.gamma = rawValue[kCGImagePropertyExifGamma] as? Double
        self.imageUniqueID = rawValue[kCGImagePropertyExifImageUniqueID] as? String
        self.isoSpeed = rawValue[kCGImagePropertyExifISOSpeed] as? Int
        self.isoSpeedLatitudeYYY = rawValue[kCGImagePropertyExifISOSpeedLatitudeyyy] as? Int
        self.isoSpeedLatitudeZZZ = rawValue[kCGImagePropertyExifISOSpeedLatitudezzz] as? Int
        self.isoSpeedRatings = rawValue[kCGImagePropertyExifISOSpeedRatings] as? [Int]
        self.lensMake = rawValue[kCGImagePropertyExifLensMake] as? String
        self.lensSpecification = rawValue[kCGImagePropertyExifLensSpecification] as? String
        
        self.lightSource = (rawValue[kCGImagePropertyExifLightSource] as? Int)
            .map({ EXIF.LightSource(rawValue: $0) }) ?? nil
        
        self.makerNote = rawValue[kCGImagePropertyExifMakerNote] as? String
        self.maxApertureValue = rawValue[kCGImagePropertyExifMaxApertureValue] as? Double
        
        self.meteringMode = (rawValue[kCGImagePropertyExifMeteringMode] as? Int)
            .map({ EXIF.MeteringMode(rawValue: $0) }) ?? nil
        
        self.oecf = rawValue[kCGImagePropertyExifOECF] as? String
        
        let offset = rawValue[kCGImagePropertyExifOffsetTime] as? String
        self.offsetTime = offset
        self.timeZone = Self.timeZone(forOffset: offset)
        
        self.pixelXDimension = rawValue[kCGImagePropertyExifPixelXDimension] as? Int
        self.pixelYDimension = rawValue[kCGImagePropertyExifPixelYDimension] as? Int
        self.recommendedExposureIndex = rawValue[kCGImagePropertyExifRecommendedExposureIndex] as? Int
        self.relatedSoundFile = rawValue[kCGImagePropertyExifRelatedSoundFile] as? String
        
        self.saturation = (rawValue[kCGImagePropertyExifSaturation] as? Int)
            .map({ EXIF.Saturation(rawValue: $0) }) ?? nil
        
        self.sceneCaptureType = (rawValue[kCGImagePropertyExifSceneCaptureType] as? Int)
            .map({ EXIF.SceneCaptureType(rawValue: $0) }) ?? nil
        
        self.sceneType = rawValue[kCGImagePropertyExifSceneType] as? Int
        
        self.sensingMethod = (rawValue[kCGImagePropertyExifSensingMethod] as? Int)
            .map({ EXIF.SensingMethod(rawValue: $0) }) ?? nil
        
        self.sensitivityType = rawValue[kCGImagePropertyExifSensitivityType] as? Double
        
        self.sharpness = (rawValue[kCGImagePropertyExifSharpness] as? Int)
            .map({ EXIF.Sharpness(rawValue: $0) }) ?? nil
        
        self.shutterSpeedValue = rawValue[kCGImagePropertyExifShutterSpeedValue] as? Double
        self.sourceExposureTimesOfCompositeImage = rawValue[kCGImagePropertyExifSourceExposureTimesOfCompositeImage] as? String
        self.sourceImageNumberOfCompositeImage = rawValue[kCGImagePropertyExifSourceImageNumberOfCompositeImage] as? Int
        self.spatialFrequencyResponse = rawValue[kCGImagePropertyExifSpatialFrequencyResponse] as? String
        self.spectralSensitivity = rawValue[kCGImagePropertyExifSpectralSensitivity] as? String
        self.standardOutputSensitivity = rawValue[kCGImagePropertyExifStandardOutputSensitivity] as? Double
        self.subjectArea = rawValue[kCGImagePropertyExifSubjectArea] as? [Int]
        self.subjectDistance = rawValue[kCGImagePropertyExifSubjectDistance] as? Double
        
        self.subjectDistanceRange = (rawValue[kCGImagePropertyExifSubjectDistRange] as? Int)
            .map({ EXIF.SubjectDistanceRange(rawValue: $0) }) ?? nil
        
        self.subjectLocation = rawValue[kCGImagePropertyExifSubjectLocation] as? Int
        self.subsecTime = rawValue[kCGImagePropertyExifSubsecTime] as? String
        self.userComment = rawValue[kCGImagePropertyExifUserComment] as? String
        
        if let components = rawValue[kCGImagePropertyExifVersion] as? [CustomStringConvertible] {
            self.version = components.map({ String(describing: $0) }).joined(separator: ".")
        } else {
            self.version = nil
        }
        
        self.whiteBalance = (rawValue[kCGImagePropertyExifWhiteBalance] as? Int)
            .map({ EXIF.WhiteBalance(rawValue: $0) }) ?? nil
        
        // Auxiliary (ExifAux) fields. The ExifAux dictionary lives at the
        // top level alongside the EXIF dictionary, not nested inside it, so
        // it must be passed in separately.

        self.firmware = aux?[kCGImagePropertyExifAuxFirmware] as? String
        self.flashCompensation = aux?[kCGImagePropertyExifAuxFlashCompensation] as? String
        self.imageNumber = aux?[kCGImagePropertyExifAuxImageNumber] as? String
        self.lensID = aux?[kCGImagePropertyExifAuxLensID] as? String
        self.lensInfo = aux?[kCGImagePropertyExifAuxLensInfo] as? String
        // Prefer auxiliary lens model/serial; fall back to main Exif keys if not present
        self.lensModel = (aux?[kCGImagePropertyExifAuxLensModel] as? String) ?? (rawValue[kCGImagePropertyExifLensModel] as? String)
        self.lensSerialNumber = (aux?[kCGImagePropertyExifAuxLensSerialNumber] as? String) ?? (rawValue[kCGImagePropertyExifLensSerialNumber] as? String)
        self.ownerName = aux?[kCGImagePropertyExifAuxOwnerName] as? String
        self.serialNumber = aux?[kCGImagePropertyExifAuxSerialNumber] as? String
    }
    
    // MARK: - Private
    
    static private func parse(dateTime: String?, subsec: String?, timeZone: TimeZone?) throws -> Date? {
        guard var dateTime else { return nil }
        
        let subsec = subsec ?? "0"
        let ss = (try? Int(subsec, format: .number)) ?? 0
        dateTime += ".\(ss)"
                
        let style = Date.VerbatimFormatStyle(
            format: "\(year: .defaultDigits):\(month: .twoDigits):\(day: .twoDigits) \(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .oneBased)):\(minute: .twoDigits):\(second: .twoDigits).\(secondFraction: .fractional(3))",
            locale: Locale(identifier: "en_US"),
            timeZone: timeZone ?? .gmt,
            calendar: .gregorian
        )

        return try style.parseStrategy.parse(dateTime)
    }
    
    static private func timeZone(forOffset offset: String?) -> TimeZone? {
        guard let offset, !offset.isEmpty else { return nil }

        let isNegative = offset.hasPrefix("-")
        let components = offset.split(separator: ":").compactMap { try? Int(String($0), format: .number) }
        guard components.count >= 1, components.count <= 2 else { return nil }

        var seconds = abs(components[0]) * 60 * 60
        if components.count == 2 {
            seconds += abs(components[1]) * 60
        }
        if isNegative { seconds = -seconds }

        return TimeZone(secondsFromGMT: Int(seconds))
    }
}

