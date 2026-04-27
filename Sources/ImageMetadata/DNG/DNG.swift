public import Foundation
import ImageIO

/// Digital Negative (DNG)
///
/// Adobe's open, lossless raw image format. The keys mirror Apple's
/// [DNG Image Properties](https://developer.apple.com/documentation/imageio/dng-image-properties).
public struct DNG: Metadata {

    // MARK: - Identification & versioning

    /// The DNG specification version this file was written against (e.g. `"1.4.0.0"`).
    public let version: String?

    /// The oldest DNG specification version a reader needs to understand to render this file.
    public let backwardVersion: String?

    /// A unique, non-localized identifier for the camera model that produced this image.
    public let uniqueCameraModel: String?

    /// A localized name for the camera model.
    public let localizedCameraModel: String?

    /// The camera body's serial number.
    public let cameraSerialNumber: String?

    /// Lens info: min focal length, max focal length, min f-number at min focal length, min f-number at max focal length.
    public let lensInfo: [Double]?

    /// A unique identifier for the raw image data, independent of any subsequent metadata edits.
    public let rawDataUniqueID: Data?

    // MARK: - CFA pattern & sensor layout

    /// Spatial layout of the color filter array.
    public let cfaLayout: Int?

    /// Color of each plane in a CFA image.
    public let cfaPlaneColor: [Int]?

    /// The active (non-masked) area of the sensor, as `[top, left, bottom, right]`.
    public let activeArea: [Int]?

    /// Rectangles of masked (optically black) pixels, four longs per rectangle.
    public let maskedAreas: [Int]?

    /// Block size of the smallest tile used for sub-tile decoding.
    public let subTileBlockSize: [Int]?

    /// The interleave factor of pixel rows in the raw image.
    public let rowInterleaveFactor: Int?

    // MARK: - Linearization & black/white levels

    /// Lookup table mapping stored values to linear values.
    public let linearizationTable: [Int]?

    /// Repeat dimensions for the BlackLevel pattern, as `[rows, columns]`.
    public let blackLevelRepeatDim: [Int]?

    /// Per-channel black level values.
    public let blackLevel: [Double]?

    /// Per-column black level offsets.
    public let blackLevelDeltaH: [Double]?

    /// Per-row black level offsets.
    public let blackLevelDeltaV: [Double]?

    /// Maximum value in the raw image (the "white" level), per channel.
    public let whiteLevel: [Int]?

    /// Bayer green split, indicating sensitivity differences between the two greens in a Bayer pattern.
    public let bayerGreenSplit: Int?

    /// The point at which the camera's sensor response begins to clip.
    public let linearResponseLimit: Double?

    // MARK: - Default rendering geometry

    /// Default crop origin in raw pixel coordinates.
    public let defaultCropOrigin: [Double]?

    /// Default crop size in raw pixel coordinates.
    public let defaultCropSize: [Double]?

    /// Default scale factor applied during rendering, `[horizontal, vertical]`.
    public let defaultScale: [Double]?

    /// Default user crop rectangle (relative to DefaultCrop), `[top, left, bottom, right]`.
    public let defaultUserCrop: [Double]?

    /// Best-quality scale factor for the image.
    public let bestQualityScale: Double?

    /// Strength of anti-aliasing filter applied by the camera.
    public let antiAliasStrength: Double?

    /// Radius (in pixels) of chroma blur applied during demosaicing.
    public let chromaBlurRadius: Double?

    // MARK: - Color calibration & profiles

    /// Illuminant for ColorMatrix1 / CameraCalibration1.
    public let calibrationIlluminant1: Int?

    /// Illuminant for ColorMatrix2 / CameraCalibration2.
    public let calibrationIlluminant2: Int?

    /// Color matrix for the first calibration illuminant.
    public let colorMatrix1: [Double]?

    /// Color matrix for the second calibration illuminant.
    public let colorMatrix2: [Double]?

    /// Camera calibration matrix for the first illuminant.
    public let cameraCalibration1: [Double]?

    /// Camera calibration matrix for the second illuminant.
    public let cameraCalibration2: [Double]?

    /// Reduction matrix for the first illuminant (used to convert to a 3-channel space).
    public let reductionMatrix1: [Double]?

    /// Reduction matrix for the second illuminant.
    public let reductionMatrix2: [Double]?

    /// Forward matrix for the first illuminant (camera native to PCS).
    public let forwardMatrix1: [Double]?

    /// Forward matrix for the second illuminant.
    public let forwardMatrix2: [Double]?

    /// Analog balance applied to each channel before the camera's color matrices.
    public let analogBalance: [Double]?

    /// As-shot per-channel neutral coefficients.
    public let asShotNeutral: [Double]?

    /// As-shot white point in chromaticity (xy) coordinates.
    public let asShotWhiteXY: [Double]?

    /// Per-camera-model signature for matching CameraCalibration matrices.
    public let cameraCalibrationSignature: String?

    /// Per-camera-model signature for matching DNG profiles.
    public let profileCalibrationSignature: String?

    // MARK: - Exposure & noise

    /// Baseline exposure compensation, in stops.
    public let baselineExposure: Double?

    /// Default offset to apply on top of BaselineExposure.
    public let baselineExposureOffset: Double?

    /// Baseline noise estimate.
    public let baselineNoise: Double?

    /// Baseline sharpness estimate.
    public let baselineSharpness: Double?

    /// Per-channel noise profile (variance pairs).
    public let noiseProfile: [Double]?

    /// Whether the camera applied noise reduction; non-zero means yes.
    public let noiseReductionApplied: Double?

    /// Shadow scale factor, applied to render shadows.
    public let shadowScale: Double?

    /// Default scale to apply when rendering "black" pixels in the rendered output.
    public let defaultBlackRender: Int?

    // MARK: - Profiles

    /// Name of the embedded camera profile.
    public let profileName: String?

    /// Copyright string for the embedded profile.
    public let profileCopyright: String?

    /// Profile embed policy (allow/deny copying).
    public let profileEmbedPolicy: Int?

    /// As-shot profile name selected by the camera.
    public let asShotProfileName: String?

    /// As-shot pre-profile matrix (applied before the profile's color transform).
    public let asShotPreProfileMatrix: [Double]?

    /// As-shot embedded ICC profile.
    public let asShotICCProfile: Data?

    /// Currently selected pre-profile matrix.
    public let currentPreProfileMatrix: [Double]?

    /// Currently selected embedded ICC profile.
    public let currentICCProfile: Data?

    /// Hue/saturation map (illuminant 1).
    public let profileHueSatMapData1: [Double]?

    /// Hue/saturation map (illuminant 2).
    public let profileHueSatMapData2: [Double]?

    /// Hue/saturation map dimensions: `[hueDivisions, saturationDivisions, valueDivisions]`.
    public let profileHueSatMapDims: [Int]?

    /// Encoding used by the hue/saturation map (linear or sRGB).
    public let profileHueSatMapEncoding: Int?

    /// 3-D look-up table data.
    public let profileLookTableData: [Double]?

    /// 3-D look-up table dimensions.
    public let profileLookTableDims: [Int]?

    /// Encoding used by the look table.
    public let profileLookTableEncoding: Int?

    /// Tone curve applied by the profile.
    public let profileToneCurve: [Double]?

    /// Reference output color space for the rendered image (scene vs. output referred).
    public let colorimetricReference: Int?

    /// List of additional camera profiles.
    public let extraCameraProfiles: [Int]?

    // MARK: - Original raw provenance

    /// Filename of the original raw file from which this DNG was derived.
    public let originalRawFileName: String?

    /// The full bytes of the original raw file (compressed).
    public let originalRawFileData: Data?

    /// Digest of the original raw file.
    public let originalRawFileDigest: Data?

    /// Default crop size used by the original raw renderer.
    public let originalDefaultCropSize: [Double]?

    /// Default final size used by the original raw renderer.
    public let originalDefaultFinalSize: [Int]?

    /// Best-quality final size used by the original raw renderer.
    public let originalBestQualityFinalSize: [Int]?

    /// Digest of the raw image data.
    public let rawImageDigest: Data?

    /// New (DNG 1.4+) digest of the raw image data.
    public let newRawImageDigest: Data?

    /// Gain factor between the raw image and its embedded preview.
    public let rawToPreviewGain: Double?

    // MARK: - Preview

    /// Application that rendered the preview.
    public let previewApplicationName: String?

    /// Version of the application that rendered the preview.
    public let previewApplicationVersion: String?

    /// Name of the rendering settings used for the preview.
    public let previewSettingsName: String?

    /// Digest of the rendering settings used for the preview.
    public let previewSettingsDigest: Data?

    /// Color space of the embedded preview.
    public let previewColorSpace: Int?

    /// Date/time the preview was rendered (ISO 8601).
    public let previewDateTime: Date?

    // MARK: - Opcodes

    /// Opcode list applied before the linearization step.
    public let opcodeList1: Data?

    /// Opcode list applied between linearization and demosaic.
    public let opcodeList2: Data?

    /// Opcode list applied after demosaic.
    public let opcodeList3: Data?

    /// Rectilinear lens warp opcode descriptor.
    public let warpRectilinear: String?

    /// Fisheye lens warp opcode descriptor.
    public let warpFisheye: String?

    /// Radial vignette correction opcode descriptor.
    public let fixVignetteRadial: String?

    // MARK: - Misc

    /// Flag indicating whether MakerNote data is safe to copy across edits.
    public let makerNoteSafety: Int?

    /// Camera-private data block.
    public let privateData: Data?

    // MARK: - Initialization

    public init(rawValue: NSDictionary) {
        self.version = Self.versionString(rawValue[kCGImagePropertyDNGVersion])
        self.backwardVersion = Self.versionString(rawValue[kCGImagePropertyDNGBackwardVersion])
        self.uniqueCameraModel = rawValue[kCGImagePropertyDNGUniqueCameraModel] as? String
        self.localizedCameraModel = rawValue[kCGImagePropertyDNGLocalizedCameraModel] as? String
        self.cameraSerialNumber = rawValue[kCGImagePropertyDNGCameraSerialNumber] as? String
        self.lensInfo = Self.doubleArray(rawValue[kCGImagePropertyDNGLensInfo])
        self.rawDataUniqueID = rawValue[kCGImagePropertyDNGRawDataUniqueID] as? Data

        self.cfaLayout = rawValue[kCGImagePropertyDNGCFALayout] as? Int
        self.cfaPlaneColor = Self.intArray(rawValue[kCGImagePropertyDNGCFAPlaneColor])
        self.activeArea = Self.intArray(rawValue[kCGImagePropertyDNGActiveArea])
        self.maskedAreas = Self.intArray(rawValue[kCGImagePropertyDNGMaskedAreas])
        self.subTileBlockSize = Self.intArray(rawValue[kCGImagePropertyDNGSubTileBlockSize])
        self.rowInterleaveFactor = rawValue[kCGImagePropertyDNGRowInterleaveFactor] as? Int

        self.linearizationTable = Self.intArray(rawValue[kCGImagePropertyDNGLinearizationTable])
        self.blackLevelRepeatDim = Self.intArray(rawValue[kCGImagePropertyDNGBlackLevelRepeatDim])
        self.blackLevel = Self.doubleArray(rawValue[kCGImagePropertyDNGBlackLevel])
        self.blackLevelDeltaH = Self.doubleArray(rawValue[kCGImagePropertyDNGBlackLevelDeltaH])
        self.blackLevelDeltaV = Self.doubleArray(rawValue[kCGImagePropertyDNGBlackLevelDeltaV])
        self.whiteLevel = Self.intArray(rawValue[kCGImagePropertyDNGWhiteLevel])
        self.bayerGreenSplit = rawValue[kCGImagePropertyDNGBayerGreenSplit] as? Int
        self.linearResponseLimit = rawValue[kCGImagePropertyDNGLinearResponseLimit] as? Double

        self.defaultCropOrigin = Self.doubleArray(rawValue[kCGImagePropertyDNGDefaultCropOrigin])
        self.defaultCropSize = Self.doubleArray(rawValue[kCGImagePropertyDNGDefaultCropSize])
        self.defaultScale = Self.doubleArray(rawValue[kCGImagePropertyDNGDefaultScale])
        self.defaultUserCrop = Self.doubleArray(rawValue[kCGImagePropertyDNGDefaultUserCrop])
        self.bestQualityScale = rawValue[kCGImagePropertyDNGBestQualityScale] as? Double
        self.antiAliasStrength = rawValue[kCGImagePropertyDNGAntiAliasStrength] as? Double
        self.chromaBlurRadius = rawValue[kCGImagePropertyDNGChromaBlurRadius] as? Double

        self.calibrationIlluminant1 = rawValue[kCGImagePropertyDNGCalibrationIlluminant1] as? Int
        self.calibrationIlluminant2 = rawValue[kCGImagePropertyDNGCalibrationIlluminant2] as? Int
        self.colorMatrix1 = Self.doubleArray(rawValue[kCGImagePropertyDNGColorMatrix1])
        self.colorMatrix2 = Self.doubleArray(rawValue[kCGImagePropertyDNGColorMatrix2])
        self.cameraCalibration1 = Self.doubleArray(rawValue[kCGImagePropertyDNGCameraCalibration1])
        self.cameraCalibration2 = Self.doubleArray(rawValue[kCGImagePropertyDNGCameraCalibration2])
        self.reductionMatrix1 = Self.doubleArray(rawValue[kCGImagePropertyDNGReductionMatrix1])
        self.reductionMatrix2 = Self.doubleArray(rawValue[kCGImagePropertyDNGReductionMatrix2])
        self.forwardMatrix1 = Self.doubleArray(rawValue[kCGImagePropertyDNGForwardMatrix1])
        self.forwardMatrix2 = Self.doubleArray(rawValue[kCGImagePropertyDNGForwardMatrix2])
        self.analogBalance = Self.doubleArray(rawValue[kCGImagePropertyDNGAnalogBalance])
        self.asShotNeutral = Self.doubleArray(rawValue[kCGImagePropertyDNGAsShotNeutral])
        self.asShotWhiteXY = Self.doubleArray(rawValue[kCGImagePropertyDNGAsShotWhiteXY])
        self.cameraCalibrationSignature = rawValue[kCGImagePropertyDNGCameraCalibrationSignature] as? String
        self.profileCalibrationSignature = rawValue[kCGImagePropertyDNGProfileCalibrationSignature] as? String

        self.baselineExposure = rawValue[kCGImagePropertyDNGBaselineExposure] as? Double
        self.baselineExposureOffset = rawValue[kCGImagePropertyDNGBaselineExposureOffset] as? Double
        self.baselineNoise = rawValue[kCGImagePropertyDNGBaselineNoise] as? Double
        self.baselineSharpness = rawValue[kCGImagePropertyDNGBaselineSharpness] as? Double
        self.noiseProfile = Self.doubleArray(rawValue[kCGImagePropertyDNGNoiseProfile])
        self.noiseReductionApplied = rawValue[kCGImagePropertyDNGNoiseReductionApplied] as? Double
        self.shadowScale = rawValue[kCGImagePropertyDNGShadowScale] as? Double
        self.defaultBlackRender = rawValue[kCGImagePropertyDNGDefaultBlackRender] as? Int

        self.profileName = rawValue[kCGImagePropertyDNGProfileName] as? String
        self.profileCopyright = rawValue[kCGImagePropertyDNGProfileCopyright] as? String
        self.profileEmbedPolicy = rawValue[kCGImagePropertyDNGProfileEmbedPolicy] as? Int
        self.asShotProfileName = rawValue[kCGImagePropertyDNGAsShotProfileName] as? String
        self.asShotPreProfileMatrix = Self.doubleArray(rawValue[kCGImagePropertyDNGAsShotPreProfileMatrix])
        self.asShotICCProfile = rawValue[kCGImagePropertyDNGAsShotICCProfile] as? Data
        self.currentPreProfileMatrix = Self.doubleArray(rawValue[kCGImagePropertyDNGCurrentPreProfileMatrix])
        self.currentICCProfile = rawValue[kCGImagePropertyDNGCurrentICCProfile] as? Data
        self.profileHueSatMapData1 = Self.doubleArray(rawValue[kCGImagePropertyDNGProfileHueSatMapData1])
        self.profileHueSatMapData2 = Self.doubleArray(rawValue[kCGImagePropertyDNGProfileHueSatMapData2])
        self.profileHueSatMapDims = Self.intArray(rawValue[kCGImagePropertyDNGProfileHueSatMapDims])
        self.profileHueSatMapEncoding = rawValue[kCGImagePropertyDNGProfileHueSatMapEncoding] as? Int
        self.profileLookTableData = Self.doubleArray(rawValue[kCGImagePropertyDNGProfileLookTableData])
        self.profileLookTableDims = Self.intArray(rawValue[kCGImagePropertyDNGProfileLookTableDims])
        self.profileLookTableEncoding = rawValue[kCGImagePropertyDNGProfileLookTableEncoding] as? Int
        self.profileToneCurve = Self.doubleArray(rawValue[kCGImagePropertyDNGProfileToneCurve])
        self.colorimetricReference = rawValue[kCGImagePropertyDNGColorimetricReference] as? Int
        self.extraCameraProfiles = Self.intArray(rawValue[kCGImagePropertyDNGExtraCameraProfiles])

        self.originalRawFileName = rawValue[kCGImagePropertyDNGOriginalRawFileName] as? String
        self.originalRawFileData = rawValue[kCGImagePropertyDNGOriginalRawFileData] as? Data
        self.originalRawFileDigest = rawValue[kCGImagePropertyDNGOriginalRawFileDigest] as? Data
        self.originalDefaultCropSize = Self.doubleArray(rawValue[kCGImagePropertyDNGOriginalDefaultCropSize])
        self.originalDefaultFinalSize = Self.intArray(rawValue[kCGImagePropertyDNGOriginalDefaultFinalSize])
        self.originalBestQualityFinalSize = Self.intArray(rawValue[kCGImagePropertyDNGOriginalBestQualityFinalSize])
        self.rawImageDigest = rawValue[kCGImagePropertyDNGRawImageDigest] as? Data
        self.newRawImageDigest = rawValue[kCGImagePropertyDNGNewRawImageDigest] as? Data
        self.rawToPreviewGain = rawValue[kCGImagePropertyDNGRawToPreviewGain] as? Double

        self.previewApplicationName = rawValue[kCGImagePropertyDNGPreviewApplicationName] as? String
        self.previewApplicationVersion = rawValue[kCGImagePropertyDNGPreviewApplicationVersion] as? String
        self.previewSettingsName = rawValue[kCGImagePropertyDNGPreviewSettingsName] as? String
        self.previewSettingsDigest = rawValue[kCGImagePropertyDNGPreviewSettingsDigest] as? Data
        self.previewColorSpace = rawValue[kCGImagePropertyDNGPreviewColorSpace] as? Int

        if let dateString = rawValue[kCGImagePropertyDNGPreviewDateTime] as? String {
            if let iso = try? Date.ISO8601FormatStyle().parse(dateString) {
                self.previewDateTime = iso
            } else {
                // Fallback: some writers emit the EXIF "YYYY:MM:DD HH:MM:SS" form.
                let exifStrategy = Date.VerbatimFormatStyle(
                    format: "\(year: .defaultDigits):\(month: .twoDigits):\(day: .twoDigits) \(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .oneBased)):\(minute: .twoDigits):\(second: .twoDigits)",
                    locale: Locale(identifier: "en_US"),
                    timeZone: .current,
                    calendar: .gregorian
                ).parseStrategy
                self.previewDateTime = try? exifStrategy.parse(dateString)
            }
        } else {
            self.previewDateTime = nil
        }

        self.opcodeList1 = rawValue[kCGImagePropertyDNGOpcodeList1] as? Data
        self.opcodeList2 = rawValue[kCGImagePropertyDNGOpcodeList2] as? Data
        self.opcodeList3 = rawValue[kCGImagePropertyDNGOpcodeList3] as? Data
        self.warpRectilinear = Self.describe(rawValue[kCGImagePropertyDNGWarpRectilinear])
        self.warpFisheye = Self.describe(rawValue[kCGImagePropertyDNGWarpFisheye])
        self.fixVignetteRadial = Self.describe(rawValue[kCGImagePropertyDNGFixVignetteRadial])

        self.makerNoteSafety = rawValue[kCGImagePropertyDNGMakerNoteSafety] as? Int
        self.privateData = rawValue[kCGImagePropertyDNGPrivateData] as? Data
    }
}
