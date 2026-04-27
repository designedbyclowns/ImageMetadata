import Testing
import Foundation
import ImageIO
@testable import ImageMetadata


struct DNGTests {
    static func sampleRawDNG() -> NSDictionary {
        return [
            // Identification & versioning
            kCGImagePropertyDNGVersion: [1, 4, 0, 0],
            kCGImagePropertyDNGBackwardVersion: [1, 1, 0, 0],
            kCGImagePropertyDNGUniqueCameraModel: "Canon EOS 5D Mark IV",
            kCGImagePropertyDNGLocalizedCameraModel: "Canon EOS 5D Mark IV",
            kCGImagePropertyDNGCameraSerialNumber: "0123456789",
            kCGImagePropertyDNGLensInfo: [24.0, 70.0, 2.8, 2.8],
            kCGImagePropertyDNGRawDataUniqueID: Data(repeating: 0xAB, count: 16),

            // CFA / sensor layout
            kCGImagePropertyDNGCFALayout: 1,
            kCGImagePropertyDNGCFAPlaneColor: [0, 1, 2],
            kCGImagePropertyDNGActiveArea: [0, 0, 4000, 6000],
            kCGImagePropertyDNGMaskedAreas: [0, 0, 8, 6000],
            kCGImagePropertyDNGSubTileBlockSize: [256, 256],
            kCGImagePropertyDNGRowInterleaveFactor: 2,

            // Linearization & black/white
            kCGImagePropertyDNGLinearizationTable: Array(0..<512),
            kCGImagePropertyDNGBlackLevelRepeatDim: [2, 2],
            kCGImagePropertyDNGBlackLevel: [128.0, 128.0, 128.0, 128.0],
            kCGImagePropertyDNGBlackLevelDeltaH: [0.0, 0.0, 0.0, 0.0],
            kCGImagePropertyDNGBlackLevelDeltaV: [0.0, 0.0, 0.0, 0.0],
            kCGImagePropertyDNGWhiteLevel: [16383, 16383, 16383],
            kCGImagePropertyDNGBayerGreenSplit: 0,
            kCGImagePropertyDNGLinearResponseLimit: 1.0,

            // Default rendering geometry
            kCGImagePropertyDNGDefaultCropOrigin: [0.0, 0.0],
            kCGImagePropertyDNGDefaultCropSize: [6000.0, 4000.0],
            kCGImagePropertyDNGDefaultScale: [1.0, 1.0],
            kCGImagePropertyDNGDefaultUserCrop: [0.0, 0.0, 1.0, 1.0],
            kCGImagePropertyDNGBestQualityScale: 1.0,
            kCGImagePropertyDNGAntiAliasStrength: 1.0,
            kCGImagePropertyDNGChromaBlurRadius: 0.0,

            // Color calibration
            kCGImagePropertyDNGCalibrationIlluminant1: 17,
            kCGImagePropertyDNGCalibrationIlluminant2: 21,
            kCGImagePropertyDNGColorMatrix1: [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
            kCGImagePropertyDNGColorMatrix2: [0.9, 0.0, 0.0, 0.0, 0.9, 0.0, 0.0, 0.0, 0.9],
            kCGImagePropertyDNGCameraCalibration1: [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
            kCGImagePropertyDNGCameraCalibration2: [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
            kCGImagePropertyDNGReductionMatrix1: [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
            kCGImagePropertyDNGReductionMatrix2: [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
            kCGImagePropertyDNGForwardMatrix1: [0.5, 0.3, 0.1, 0.2, 0.7, 0.1, 0.0, 0.0, 0.8],
            kCGImagePropertyDNGForwardMatrix2: [0.5, 0.3, 0.1, 0.2, 0.7, 0.1, 0.0, 0.0, 0.8],
            kCGImagePropertyDNGAnalogBalance: [1.0, 1.0, 1.0],
            kCGImagePropertyDNGAsShotNeutral: [0.5, 1.0, 0.7],
            kCGImagePropertyDNGAsShotWhiteXY: [0.3127, 0.329],
            kCGImagePropertyDNGCameraCalibrationSignature: "com.example.calibration",
            kCGImagePropertyDNGProfileCalibrationSignature: "com.example.profile",

            // Exposure & noise
            kCGImagePropertyDNGBaselineExposure: 0.25,
            kCGImagePropertyDNGBaselineExposureOffset: 0.0,
            kCGImagePropertyDNGBaselineNoise: 1.0,
            kCGImagePropertyDNGBaselineSharpness: 1.0,
            kCGImagePropertyDNGNoiseProfile: [0.0001, 0.000001],
            kCGImagePropertyDNGNoiseReductionApplied: 0.0,
            kCGImagePropertyDNGShadowScale: 1.0,
            kCGImagePropertyDNGDefaultBlackRender: 0,

            // Profiles
            kCGImagePropertyDNGProfileName: "Adobe Standard",
            kCGImagePropertyDNGProfileCopyright: "© 2025 Example",
            kCGImagePropertyDNGProfileEmbedPolicy: 1,
            kCGImagePropertyDNGAsShotProfileName: "Adobe Standard",
            kCGImagePropertyDNGAsShotPreProfileMatrix: [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
            kCGImagePropertyDNGAsShotICCProfile: Data(repeating: 0x01, count: 3144),
            kCGImagePropertyDNGCurrentPreProfileMatrix: [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
            kCGImagePropertyDNGCurrentICCProfile: Data(repeating: 0x02, count: 3144),
            kCGImagePropertyDNGProfileHueSatMapData1: [0.0, 1.0, 1.0, 0.0, 1.0, 1.0],
            kCGImagePropertyDNGProfileHueSatMapData2: [0.0, 1.0, 1.0, 0.0, 1.0, 1.0],
            kCGImagePropertyDNGProfileHueSatMapDims: [90, 30, 1],
            kCGImagePropertyDNGProfileHueSatMapEncoding: 0,
            kCGImagePropertyDNGProfileLookTableData: [0.0, 1.0, 1.0, 0.0, 1.0, 1.0],
            kCGImagePropertyDNGProfileLookTableDims: [90, 30, 1],
            kCGImagePropertyDNGProfileLookTableEncoding: 0,
            kCGImagePropertyDNGProfileToneCurve: [0.0, 0.0, 1.0, 1.0],
            kCGImagePropertyDNGColorimetricReference: 0,
            kCGImagePropertyDNGExtraCameraProfiles: [12345, 67890],

            // Original raw provenance
            kCGImagePropertyDNGOriginalRawFileName: "IMG_0001.CR2",
            kCGImagePropertyDNGOriginalRawFileData: Data(repeating: 0xFF, count: 1_048_576),
            kCGImagePropertyDNGOriginalRawFileDigest: Data(repeating: 0xCD, count: 16),
            kCGImagePropertyDNGOriginalDefaultCropSize: [6000.0, 4000.0],
            kCGImagePropertyDNGOriginalDefaultFinalSize: [6000, 4000],
            kCGImagePropertyDNGOriginalBestQualityFinalSize: [6000, 4000],
            kCGImagePropertyDNGRawImageDigest: Data(repeating: 0xEF, count: 16),
            kCGImagePropertyDNGNewRawImageDigest: Data(repeating: 0x12, count: 16),
            kCGImagePropertyDNGRawToPreviewGain: 1.0,

            // Preview
            kCGImagePropertyDNGPreviewApplicationName: "Adobe DNG Converter",
            kCGImagePropertyDNGPreviewApplicationVersion: "16.0",
            kCGImagePropertyDNGPreviewSettingsName: "Default",
            kCGImagePropertyDNGPreviewSettingsDigest: Data(repeating: 0x99, count: 16),
            kCGImagePropertyDNGPreviewColorSpace: 2,
            kCGImagePropertyDNGPreviewDateTime: "2025-02-13T15:34:57Z",

            // Opcodes
            kCGImagePropertyDNGOpcodeList1: Data(repeating: 0xA1, count: 256),
            kCGImagePropertyDNGOpcodeList2: Data(repeating: 0xA2, count: 512),
            kCGImagePropertyDNGOpcodeList3: Data(repeating: 0xA3, count: 1024),
            kCGImagePropertyDNGWarpRectilinear: ["k0": 1.0],
            kCGImagePropertyDNGWarpFisheye: ["k0": 0.5],
            kCGImagePropertyDNGFixVignetteRadial: ["k0": 0.1],

            // Misc
            kCGImagePropertyDNGMakerNoteSafety: 1,
            kCGImagePropertyDNGPrivateData: Data(repeating: 0x55, count: 4096),
        ]
    }

    let dng: DNG

    init() {
        self.dng = DNG(rawValue: Self.sampleRawDNG())
    }

    // MARK: - Identification

    @Test func version() {
        #expect(dng.version == "1.4.0.0")
    }

    @Test func backwardVersion() {
        #expect(dng.backwardVersion == "1.1.0.0")
    }

    @Test func uniqueCameraModel() {
        #expect(dng.uniqueCameraModel == "Canon EOS 5D Mark IV")
    }

    @Test func localizedCameraModel() {
        #expect(dng.localizedCameraModel == "Canon EOS 5D Mark IV")
    }

    @Test func cameraSerialNumber() {
        #expect(dng.cameraSerialNumber == "0123456789")
    }

    @Test func lensInfo() {
        #expect(dng.lensInfo == [24.0, 70.0, 2.8, 2.8])
    }

    @Test func rawDataUniqueID() {
        #expect(dng.rawDataUniqueID?.count == 16)
    }

    // MARK: - CFA / sensor

    @Test func cfaLayout() {
        #expect(dng.cfaLayout == 1)
    }

    @Test func cfaPlaneColor() {
        #expect(dng.cfaPlaneColor == [0, 1, 2])
    }

    @Test func activeArea() {
        #expect(dng.activeArea == [0, 0, 4000, 6000])
    }

    @Test func maskedAreas() {
        #expect(dng.maskedAreas == [0, 0, 8, 6000])
    }

    @Test func subTileBlockSize() {
        #expect(dng.subTileBlockSize == [256, 256])
    }

    @Test func rowInterleaveFactor() {
        #expect(dng.rowInterleaveFactor == 2)
    }

    // MARK: - Levels

    @Test func linearizationTable() {
        #expect(dng.linearizationTable?.count == 512)
        #expect(dng.linearizationTable?.first == 0)
        #expect(dng.linearizationTable?.last == 511)
    }

    @Test func blackLevelRepeatDim() {
        #expect(dng.blackLevelRepeatDim == [2, 2])
    }

    @Test func blackLevel() {
        #expect(dng.blackLevel == [128.0, 128.0, 128.0, 128.0])
    }

    @Test func whiteLevel() {
        #expect(dng.whiteLevel == [16383, 16383, 16383])
    }

    @Test func bayerGreenSplit() {
        #expect(dng.bayerGreenSplit == 0)
    }

    @Test func linearResponseLimit() {
        #expect(dng.linearResponseLimit == 1.0)
    }

    // MARK: - Geometry

    @Test func defaultCropOrigin() {
        #expect(dng.defaultCropOrigin == [0.0, 0.0])
    }

    @Test func defaultCropSize() {
        #expect(dng.defaultCropSize == [6000.0, 4000.0])
    }

    @Test func defaultScale() {
        #expect(dng.defaultScale == [1.0, 1.0])
    }

    @Test func defaultUserCrop() {
        #expect(dng.defaultUserCrop == [0.0, 0.0, 1.0, 1.0])
    }

    @Test func bestQualityScale() {
        #expect(dng.bestQualityScale == 1.0)
    }

    // MARK: - Color calibration

    @Test func calibrationIlluminants() {
        #expect(dng.calibrationIlluminant1 == 17)
        #expect(dng.calibrationIlluminant2 == 21)
    }

    @Test func colorMatrices() {
        #expect(dng.colorMatrix1?.count == 9)
        #expect(dng.colorMatrix2?.count == 9)
    }

    @Test func forwardMatrices() {
        #expect(dng.forwardMatrix1 == [0.5, 0.3, 0.1, 0.2, 0.7, 0.1, 0.0, 0.0, 0.8])
        #expect(dng.forwardMatrix2 == [0.5, 0.3, 0.1, 0.2, 0.7, 0.1, 0.0, 0.0, 0.8])
    }

    @Test func asShotNeutral() {
        #expect(dng.asShotNeutral == [0.5, 1.0, 0.7])
    }

    @Test func asShotWhiteXY() {
        #expect(dng.asShotWhiteXY == [0.3127, 0.329])
    }

    @Test func calibrationSignatures() {
        #expect(dng.cameraCalibrationSignature == "com.example.calibration")
        #expect(dng.profileCalibrationSignature == "com.example.profile")
    }

    // MARK: - Exposure & noise

    @Test func baselineExposure() {
        #expect(dng.baselineExposure == 0.25)
        #expect(dng.baselineExposureOffset == 0.0)
        #expect(dng.baselineNoise == 1.0)
        #expect(dng.baselineSharpness == 1.0)
    }

    @Test func noiseProfile() {
        #expect(dng.noiseProfile == [0.0001, 0.000001])
    }

    // MARK: - Profiles

    @Test func profileName() {
        #expect(dng.profileName == "Adobe Standard")
    }

    @Test func profileCopyright() {
        #expect(dng.profileCopyright == "© 2025 Example")
    }

    @Test func profileEmbedPolicy() {
        #expect(dng.profileEmbedPolicy == 1)
    }

    @Test func iccProfiles() {
        #expect(dng.asShotICCProfile?.count == 3144)
        #expect(dng.currentICCProfile?.count == 3144)
    }

    @Test func hueSatMaps() {
        #expect(dng.profileHueSatMapDims == [90, 30, 1])
        #expect(dng.profileHueSatMapData1?.count == 6)
        #expect(dng.profileHueSatMapData2?.count == 6)
        #expect(dng.profileHueSatMapEncoding == 0)
    }

    @Test func lookTable() {
        #expect(dng.profileLookTableDims == [90, 30, 1])
        #expect(dng.profileLookTableData?.count == 6)
        #expect(dng.profileLookTableEncoding == 0)
    }

    @Test func toneCurve() {
        #expect(dng.profileToneCurve == [0.0, 0.0, 1.0, 1.0])
    }

    @Test func colorimetricReference() {
        #expect(dng.colorimetricReference == 0)
    }

    @Test func extraCameraProfiles() {
        #expect(dng.extraCameraProfiles == [12345, 67890])
    }

    // MARK: - Original raw

    @Test func originalRawFileName() {
        #expect(dng.originalRawFileName == "IMG_0001.CR2")
    }

    @Test func originalRawFileData() {
        #expect(dng.originalRawFileData?.count == 1_048_576)
    }

    @Test func rawDigests() {
        #expect(dng.rawImageDigest?.count == 16)
        #expect(dng.newRawImageDigest?.count == 16)
        #expect(dng.originalRawFileDigest?.count == 16)
    }

    @Test func rawToPreviewGain() {
        #expect(dng.rawToPreviewGain == 1.0)
    }

    // MARK: - Preview

    @Test func previewApplication() {
        #expect(dng.previewApplicationName == "Adobe DNG Converter")
        #expect(dng.previewApplicationVersion == "16.0")
        #expect(dng.previewSettingsName == "Default")
        #expect(dng.previewSettingsDigest?.count == 16)
        #expect(dng.previewColorSpace == 2)
    }

    @Test func previewDateTimeISO8601() throws {
        let date = try #require(dng.previewDateTime)
        let components = Calendar(identifier: .gregorian).dateComponents(
            in: TimeZone(identifier: "UTC")!,
            from: date
        )
        #expect(components.year == 2025)
        #expect(components.month == 2)
        #expect(components.day == 13)
        #expect(components.hour == 15)
        #expect(components.minute == 34)
        #expect(components.second == 57)
    }

    @Test("previewDateTime falls back to EXIF YYYY:MM:DD HH:MM:SS form")
    func previewDateTimeExifFallback() throws {
        let raw = try #require(Self.sampleRawDNG().mutableCopy() as? NSMutableDictionary)
        raw[kCGImagePropertyDNGPreviewDateTime] = "2025:02:13 15:34:57"

        let dng = DNG(rawValue: raw)
        let date = try #require(dng.previewDateTime)

        let components = Calendar(identifier: .gregorian).dateComponents(
            [.timeZone, .year, .month, .day, .hour, .minute, .second],
            from: date
        )
        #expect(components.timeZone == .current)
        #expect(components.year == 2025)
        #expect(components.month == 2)
        #expect(components.day == 13)
        #expect(components.hour == 15)
        #expect(components.minute == 34)
        #expect(components.second == 57)
    }

    // MARK: - Opcodes

    @Test func opcodeLists() {
        #expect(dng.opcodeList1?.count == 256)
        #expect(dng.opcodeList2?.count == 512)
        #expect(dng.opcodeList3?.count == 1024)
    }

    @Test func warpAndVignette() throws {
        let warpRect = try #require(dng.warpRectilinear)
        #expect(warpRect.contains("k0"))
        #expect(dng.warpFisheye != nil)
        #expect(dng.fixVignetteRadial != nil)
    }

    // MARK: - Misc

    @Test func makerNoteSafety() {
        #expect(dng.makerNoteSafety == 1)
    }

    @Test func privateData() {
        #expect(dng.privateData?.count == 4096)
    }

    // MARK: - Encoding

    @Test("Encoding emits byte counts for binary blobs and entry count for linearization table")
    func encodingByteCounts() throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        let data = try encoder.encode(dng)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

        // Replaced with byte/entry counts.
        #expect(json["asShotICCProfile"] as? Int == 3144)
        #expect(json["currentICCProfile"] as? Int == 3144)
        #expect(json["originalRawFileData"] as? Int == 1_048_576)
        #expect(json["privateData"] as? Int == 4096)
        #expect(json["opcodeList1"] as? Int == 256)
        #expect(json["opcodeList2"] as? Int == 512)
        #expect(json["opcodeList3"] as? Int == 1024)
        #expect(json["linearizationTable"] as? Int == 512)

        // Small digests stay as base64-encoded strings.
        #expect(json["rawImageDigest"] is String)
        #expect(json["newRawImageDigest"] is String)
        #expect(json["originalRawFileDigest"] is String)
        #expect(json["rawDataUniqueID"] is String)
        #expect(json["previewSettingsDigest"] is String)
    }

    @Test("Encoding round-trips representative scalar and array fields")
    func encodingScalarsAndArrays() throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        let data = try encoder.encode(dng)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

        #expect(json["uniqueCameraModel"] as? String == "Canon EOS 5D Mark IV")
        #expect(json["baselineExposure"] as? Double == 0.25)
        #expect(json["calibrationIlluminant1"] as? Int == 17)
        #expect(json["lensInfo"] as? [Double] == [24.0, 70.0, 2.8, 2.8])
        #expect(json["version"] as? String == "1.4.0.0")

        let previewDate = try #require(json["previewDateTime"] as? String)
        #expect(previewDate.hasPrefix("2025-02-13T15:34:57"))
    }

    @Test("Missing or malformed values produce nils")
    func missingOrMalformedValues() throws {
        let raw = try #require(Self.sampleRawDNG().mutableCopy() as? NSMutableDictionary)
        raw[kCGImagePropertyDNGBaselineExposure] = "not-a-double"
        raw[kCGImagePropertyDNGBayerGreenSplit] = NSNull()
        raw[kCGImagePropertyDNGPreviewDateTime] = "garbage"
        raw.removeObject(forKey: kCGImagePropertyDNGUniqueCameraModel)
        raw.removeObject(forKey: kCGImagePropertyDNGAsShotNeutral)

        let dng = DNG(rawValue: raw)

        #expect(dng.baselineExposure == nil)
        #expect(dng.bayerGreenSplit == nil)
        #expect(dng.previewDateTime == nil)
        #expect(dng.uniqueCameraModel == nil)
        #expect(dng.asShotNeutral == nil)
    }

    @Test("Empty dictionary produces an all-nil DNG that encodes to {}")
    func emptyDictionary() throws {
        let dng = DNG(rawValue: [:])

        #expect(dng.uniqueCameraModel == nil)
        #expect(dng.colorMatrix1 == nil)
        #expect(dng.previewDateTime == nil)

        let encoder = JSONEncoder()
        let data = try encoder.encode(dng)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(json.isEmpty)
    }
}
