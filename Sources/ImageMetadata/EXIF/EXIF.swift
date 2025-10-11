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
    
    /// The strobe energy when the image was captured, in beam candle power seconds.
    public let flashEnergy: Double?
    
    /// The flash status when the image was shot.
    public let flash: Int?
    
    /// The Flashpix format version supported by a FPXR file.
    public let flashPixVersion: String?
    
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
    public let imageUniqueID: String?
    
    /// The ISO speed setting used to capture the image.
    public let isoSpeed: Int?
    
    /// The ISO speed latitude yyy value.
    public let isoSpeedLatitudeYYY: Int?
    
    /// The ISO speed latitude zzz value.
    public let isoSpeedLatitudeZZZ: Int?
    
    /// The ISO speed ratings.
    public let isoSpeedRatings: [Int]?
    
    /// A string with the name of the lens manufacturer.
    public let lensMake: String?
    
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
    
    // MARK: - Auxiliary (ExifAux) Stored Properties
    
    /// Firmware information.
    public let firmware: String?
    
    /// Flash compensation.
    public let flashCompensation: String?
    
    /// The image number.
    public let imageNumber: String?
    
    /// The lens ID.
    public let lensID: String?
    
    /// Lens information.
    public let lensInfo: String?
    
    /// A string with the lens model information.
    public let lensModel: String?
    
    /// A string with the lens’s serial number.
    public let lensSerialNumber: String?
    
    /// The owner name.
    public let ownerName: String?
    
    /// The serial number.
    public let serialNumber: String?
    
    public init(rawValue: NSDictionary) {
        
        
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
        
        if let v = rawValue[kCGImagePropertyExifCompositeImage] as? Int {
            self.compositeImage = CompositeImage(rawValue: v)
        } else {
            self.compositeImage = nil
        }
        
        self.compressedBitsPerPixel = rawValue[kCGImagePropertyExifCompressedBitsPerPixel] as? Double
        
        if let v = rawValue[kCGImagePropertyExifContrast] as? Int {
            self.contrast = EXIF.Contrast(rawValue: v)
        } else {
            self.contrast = nil
        }
        
        if let v = rawValue[kCGImagePropertyExifCustomRendered] as? Int {
            self.customRendered = EXIF.CustomRendered(rawValue: v)
        } else {
            self.customRendered = nil
        }
        
        if let s = rawValue[kCGImagePropertyExifDateTimeDigitized] as? String {
            self.dateTimeDigitized = EXIF.dateFormatter.date(from: s)
        } else {
            self.dateTimeDigitized = nil
        }
        
        if let s = rawValue[kCGImagePropertyExifDateTimeOriginal] as? String {
            self.dateTimeOriginal = EXIF.dateFormatter.date(from: s)
        } else {
            self.dateTimeOriginal = nil
        }
        
        self.deviceSettingDescription = rawValue[kCGImagePropertyExifDeviceSettingDescription] as? String
        self.digitalZoomRatio = rawValue[kCGImagePropertyExifDigitalZoomRatio] as? Double
        self.exposureBiasValue = rawValue[kCGImagePropertyExifExposureBiasValue] as? Double
        self.exposureIndex = rawValue[kCGImagePropertyExifExposureIndex] as? Double
        
        if let v = rawValue[kCGImagePropertyExifExposureMode] as? Int {
            self.exposureMode = EXIF.ExposureMode(rawValue: v)
        } else {
            self.exposureMode = nil
        }
        
        if let v = rawValue[kCGImagePropertyExifExposureProgram] as? Int {
            self.exposureProgram = EXIF.ExposureProgram(rawValue: v)
        } else {
            self.exposureProgram = nil
        }
        
        self.exposureTime = rawValue[kCGImagePropertyExifExposureTime] as? Double
        self.fileSource = rawValue[kCGImagePropertyExifFileSource] as? Int
        self.flashEnergy = rawValue[kCGImagePropertyExifFlashEnergy] as? Double
        self.flash = rawValue[kCGImagePropertyExifFlash] as? Int
        
        if let components = rawValue[kCGImagePropertyExifFlashPixVersion] as? [CustomStringConvertible] {
            self.flashPixVersion = components.map { String(describing: $0) }.joined(separator: ".")
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
        
        if let v = rawValue[kCGImagePropertyExifLightSource] as? Int {
            self.lightSource = EXIF.LightSource(rawValue: v)
        } else {
            self.lightSource = nil
        }
        
        self.makerNote = rawValue[kCGImagePropertyExifMakerNote] as? String
        self.maxApertureValue = rawValue[kCGImagePropertyExifMaxApertureValue] as? Double
        
        if let v = rawValue[kCGImagePropertyExifMeteringMode] as? Int {
            self.meteringMode = EXIF.MeteringMode(rawValue: v)
        } else {
            self.meteringMode = nil
        }
        
        self.oecf = rawValue[kCGImagePropertyExifOECF] as? String
        self.offsetTime = rawValue[kCGImagePropertyExifOffsetTime] as? String
        self.offsetTimeDigitized = rawValue[kCGImagePropertyExifOffsetTimeDigitized] as? String
        self.offsetTimeOriginal = rawValue[kCGImagePropertyExifOffsetTimeOriginal] as? String
        self.pixelXDimension = rawValue[kCGImagePropertyExifPixelXDimension] as? Int
        self.pixelYDimension = rawValue[kCGImagePropertyExifPixelYDimension] as? Int
        self.recommendedExposureIndex = rawValue[kCGImagePropertyExifRecommendedExposureIndex] as? Int
        self.relatedSoundFile = rawValue[kCGImagePropertyExifRelatedSoundFile] as? String
        
        if let v = rawValue[kCGImagePropertyExifSaturation] as? Int {
            self.saturation = EXIF.Saturation(rawValue: v)
        } else {
            self.saturation = nil
        }
        
        if let v = rawValue[kCGImagePropertyExifSceneCaptureType] as? Int {
            self.sceneCaptureType = EXIF.SceneCaptureType(rawValue: v)
        } else {
            self.sceneCaptureType = nil
        }
        
        self.sceneType = rawValue[kCGImagePropertyExifSceneType] as? Int
        
        if let v = rawValue[kCGImagePropertyExifSensingMethod] as? Int {
            self.sensingMethod = EXIF.SensingMethod(rawValue: v)
        } else {
            self.sensingMethod = nil
        }
        
        self.sensitivityType = rawValue[kCGImagePropertyExifSensitivityType] as? Double
        
        if let v = rawValue[kCGImagePropertyExifSharpness] as? Int {
            self.sharpness = EXIF.Sharpness(rawValue: v)
        } else {
            self.sharpness = nil
        }
        
        self.shutterSpeedValue = rawValue[kCGImagePropertyExifShutterSpeedValue] as? Double
        self.sourceExposureTimesOfCompositeImage = rawValue[kCGImagePropertyExifSourceExposureTimesOfCompositeImage] as? String
        self.sourceImageNumberOfCompositeImage = rawValue[kCGImagePropertyExifSourceImageNumberOfCompositeImage] as? Int
        self.spatialFrequencyResponse = rawValue[kCGImagePropertyExifSpatialFrequencyResponse] as? String
        self.spectralSensitivity = rawValue[kCGImagePropertyExifSpectralSensitivity] as? String
        self.standardOutputSensitivity = rawValue[kCGImagePropertyExifStandardOutputSensitivity] as? Double
        self.subjectArea = rawValue[kCGImagePropertyExifSubjectArea] as? [Int]
        self.subjectDistance = rawValue[kCGImagePropertyExifSubjectDistance] as? Double
        
        if let v = rawValue[kCGImagePropertyExifSubjectDistRange] as? Int {
            self.subjectDistanceRange = EXIF.SubjectDistanceRange(rawValue: v)
        } else {
            self.subjectDistanceRange = nil
        }
        
        self.subjectLocation = rawValue[kCGImagePropertyExifSubjectLocation] as? Int
        self.subsecTime = rawValue[kCGImagePropertyExifSubsecTime] as? String
        self.subsecTimeDigitized = rawValue[kCGImagePropertyExifSubsecTimeDigitized] as? String
        self.subsecTimeOriginal = rawValue[kCGImagePropertyExifSubsecTimeOriginal] as? String
        self.userComment = rawValue[kCGImagePropertyExifUserComment] as? String
        
        if let components = rawValue[kCGImagePropertyExifVersion] as? [CustomStringConvertible] {
            self.version = components.map { String(describing: $0) }.joined(separator: ".")
        } else {
            self.version = nil
        }
        
        if let v = rawValue[kCGImagePropertyExifWhiteBalance] as? Int {
            self.whiteBalance = EXIF.WhiteBalance(rawValue: v)
        } else {
            self.whiteBalance = nil
        }
        
        // Auxiliary (ExifAux) fields
        let aux = rawValue[kCGImagePropertyExifAuxDictionary] as? NSDictionary
        
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
    
    // MARK: - Formatters
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return formatter
    }()
    
}

