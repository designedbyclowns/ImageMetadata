import Foundation

extension DNG: Encodable {
    enum CodingKeys: String, CodingKey {
        case version
        case backwardVersion
        case uniqueCameraModel
        case localizedCameraModel
        case cameraSerialNumber
        case lensInfo
        case rawDataUniqueID

        case cfaLayout
        case cfaPlaneColor
        case activeArea
        case maskedAreas
        case subTileBlockSize
        case rowInterleaveFactor

        case linearizationTable
        case blackLevelRepeatDim
        case blackLevel
        case blackLevelDeltaH
        case blackLevelDeltaV
        case whiteLevel
        case bayerGreenSplit
        case linearResponseLimit

        case defaultCropOrigin
        case defaultCropSize
        case defaultScale
        case defaultUserCrop
        case bestQualityScale
        case antiAliasStrength
        case chromaBlurRadius

        case calibrationIlluminant1
        case calibrationIlluminant2
        case colorMatrix1
        case colorMatrix2
        case cameraCalibration1
        case cameraCalibration2
        case reductionMatrix1
        case reductionMatrix2
        case forwardMatrix1
        case forwardMatrix2
        case analogBalance
        case asShotNeutral
        case asShotWhiteXY
        case cameraCalibrationSignature
        case profileCalibrationSignature

        case baselineExposure
        case baselineExposureOffset
        case baselineNoise
        case baselineSharpness
        case noiseProfile
        case noiseReductionApplied
        case shadowScale
        case defaultBlackRender

        case profileName
        case profileCopyright
        case profileEmbedPolicy
        case asShotProfileName
        case asShotPreProfileMatrix
        case asShotICCProfile
        case currentPreProfileMatrix
        case currentICCProfile
        case profileHueSatMapData1
        case profileHueSatMapData2
        case profileHueSatMapDims
        case profileHueSatMapEncoding
        case profileLookTableData
        case profileLookTableDims
        case profileLookTableEncoding
        case profileToneCurve
        case colorimetricReference
        case extraCameraProfiles

        case originalRawFileName
        case originalRawFileData
        case originalRawFileDigest
        case originalDefaultCropSize
        case originalDefaultFinalSize
        case originalBestQualityFinalSize
        case rawImageDigest
        case newRawImageDigest
        case rawToPreviewGain

        case previewApplicationName
        case previewApplicationVersion
        case previewSettingsName
        case previewSettingsDigest
        case previewColorSpace
        case previewDateTime

        case opcodeList1
        case opcodeList2
        case opcodeList3
        case warpRectilinear
        case warpFisheye
        case fixVignetteRadial

        case makerNoteSafety
        case privateData
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(version, forKey: .version)
        try container.encodeIfPresent(backwardVersion, forKey: .backwardVersion)
        try container.encodeIfPresent(uniqueCameraModel, forKey: .uniqueCameraModel)
        try container.encodeIfPresent(localizedCameraModel, forKey: .localizedCameraModel)
        try container.encodeIfPresent(cameraSerialNumber, forKey: .cameraSerialNumber)
        try container.encodeIfPresent(lensInfo, forKey: .lensInfo)
        try container.encodeIfPresent(rawDataUniqueID, forKey: .rawDataUniqueID)

        try container.encodeIfPresent(cfaLayout, forKey: .cfaLayout)
        try container.encodeIfPresent(cfaPlaneColor, forKey: .cfaPlaneColor)
        try container.encodeIfPresent(activeArea, forKey: .activeArea)
        try container.encodeIfPresent(maskedAreas, forKey: .maskedAreas)
        try container.encodeIfPresent(subTileBlockSize, forKey: .subTileBlockSize)
        try container.encodeIfPresent(rowInterleaveFactor, forKey: .rowInterleaveFactor)

        try container.encodeIfPresent(linearizationTable?.count, forKey: .linearizationTable)
        try container.encodeIfPresent(blackLevelRepeatDim, forKey: .blackLevelRepeatDim)
        try container.encodeIfPresent(blackLevel, forKey: .blackLevel)
        try container.encodeIfPresent(blackLevelDeltaH, forKey: .blackLevelDeltaH)
        try container.encodeIfPresent(blackLevelDeltaV, forKey: .blackLevelDeltaV)
        try container.encodeIfPresent(whiteLevel, forKey: .whiteLevel)
        try container.encodeIfPresent(bayerGreenSplit, forKey: .bayerGreenSplit)
        try container.encodeIfPresent(linearResponseLimit, forKey: .linearResponseLimit)

        try container.encodeIfPresent(defaultCropOrigin, forKey: .defaultCropOrigin)
        try container.encodeIfPresent(defaultCropSize, forKey: .defaultCropSize)
        try container.encodeIfPresent(defaultScale, forKey: .defaultScale)
        try container.encodeIfPresent(defaultUserCrop, forKey: .defaultUserCrop)
        try container.encodeIfPresent(bestQualityScale, forKey: .bestQualityScale)
        try container.encodeIfPresent(antiAliasStrength, forKey: .antiAliasStrength)
        try container.encodeIfPresent(chromaBlurRadius, forKey: .chromaBlurRadius)

        try container.encodeIfPresent(calibrationIlluminant1, forKey: .calibrationIlluminant1)
        try container.encodeIfPresent(calibrationIlluminant2, forKey: .calibrationIlluminant2)
        try container.encodeIfPresent(colorMatrix1, forKey: .colorMatrix1)
        try container.encodeIfPresent(colorMatrix2, forKey: .colorMatrix2)
        try container.encodeIfPresent(cameraCalibration1, forKey: .cameraCalibration1)
        try container.encodeIfPresent(cameraCalibration2, forKey: .cameraCalibration2)
        try container.encodeIfPresent(reductionMatrix1, forKey: .reductionMatrix1)
        try container.encodeIfPresent(reductionMatrix2, forKey: .reductionMatrix2)
        try container.encodeIfPresent(forwardMatrix1, forKey: .forwardMatrix1)
        try container.encodeIfPresent(forwardMatrix2, forKey: .forwardMatrix2)
        try container.encodeIfPresent(analogBalance, forKey: .analogBalance)
        try container.encodeIfPresent(asShotNeutral, forKey: .asShotNeutral)
        try container.encodeIfPresent(asShotWhiteXY, forKey: .asShotWhiteXY)
        try container.encodeIfPresent(cameraCalibrationSignature, forKey: .cameraCalibrationSignature)
        try container.encodeIfPresent(profileCalibrationSignature, forKey: .profileCalibrationSignature)

        try container.encodeIfPresent(baselineExposure, forKey: .baselineExposure)
        try container.encodeIfPresent(baselineExposureOffset, forKey: .baselineExposureOffset)
        try container.encodeIfPresent(baselineNoise, forKey: .baselineNoise)
        try container.encodeIfPresent(baselineSharpness, forKey: .baselineSharpness)
        try container.encodeIfPresent(noiseProfile, forKey: .noiseProfile)
        try container.encodeIfPresent(noiseReductionApplied, forKey: .noiseReductionApplied)
        try container.encodeIfPresent(shadowScale, forKey: .shadowScale)
        try container.encodeIfPresent(defaultBlackRender, forKey: .defaultBlackRender)

        try container.encodeIfPresent(profileName, forKey: .profileName)
        try container.encodeIfPresent(profileCopyright, forKey: .profileCopyright)
        try container.encodeIfPresent(profileEmbedPolicy, forKey: .profileEmbedPolicy)
        try container.encodeIfPresent(asShotProfileName, forKey: .asShotProfileName)
        try container.encodeIfPresent(asShotPreProfileMatrix, forKey: .asShotPreProfileMatrix)
        try container.encodeIfPresent(asShotICCProfile?.count, forKey: .asShotICCProfile)
        try container.encodeIfPresent(currentPreProfileMatrix, forKey: .currentPreProfileMatrix)
        try container.encodeIfPresent(currentICCProfile?.count, forKey: .currentICCProfile)
        try container.encodeIfPresent(profileHueSatMapData1, forKey: .profileHueSatMapData1)
        try container.encodeIfPresent(profileHueSatMapData2, forKey: .profileHueSatMapData2)
        try container.encodeIfPresent(profileHueSatMapDims, forKey: .profileHueSatMapDims)
        try container.encodeIfPresent(profileHueSatMapEncoding, forKey: .profileHueSatMapEncoding)
        try container.encodeIfPresent(profileLookTableData, forKey: .profileLookTableData)
        try container.encodeIfPresent(profileLookTableDims, forKey: .profileLookTableDims)
        try container.encodeIfPresent(profileLookTableEncoding, forKey: .profileLookTableEncoding)
        try container.encodeIfPresent(profileToneCurve, forKey: .profileToneCurve)
        try container.encodeIfPresent(colorimetricReference, forKey: .colorimetricReference)
        try container.encodeIfPresent(extraCameraProfiles, forKey: .extraCameraProfiles)

        try container.encodeIfPresent(originalRawFileName, forKey: .originalRawFileName)
        try container.encodeIfPresent(originalRawFileData?.count, forKey: .originalRawFileData)
        try container.encodeIfPresent(originalRawFileDigest, forKey: .originalRawFileDigest)
        try container.encodeIfPresent(originalDefaultCropSize, forKey: .originalDefaultCropSize)
        try container.encodeIfPresent(originalDefaultFinalSize, forKey: .originalDefaultFinalSize)
        try container.encodeIfPresent(originalBestQualityFinalSize, forKey: .originalBestQualityFinalSize)
        try container.encodeIfPresent(rawImageDigest, forKey: .rawImageDigest)
        try container.encodeIfPresent(newRawImageDigest, forKey: .newRawImageDigest)
        try container.encodeIfPresent(rawToPreviewGain, forKey: .rawToPreviewGain)

        try container.encodeIfPresent(previewApplicationName, forKey: .previewApplicationName)
        try container.encodeIfPresent(previewApplicationVersion, forKey: .previewApplicationVersion)
        try container.encodeIfPresent(previewSettingsName, forKey: .previewSettingsName)
        try container.encodeIfPresent(previewSettingsDigest, forKey: .previewSettingsDigest)
        try container.encodeIfPresent(previewColorSpace, forKey: .previewColorSpace)
        try container.encodeIfPresent(previewDateTime, forKey: .previewDateTime)

        try container.encodeIfPresent(opcodeList1?.count, forKey: .opcodeList1)
        try container.encodeIfPresent(opcodeList2?.count, forKey: .opcodeList2)
        try container.encodeIfPresent(opcodeList3?.count, forKey: .opcodeList3)
        try container.encodeIfPresent(warpRectilinear, forKey: .warpRectilinear)
        try container.encodeIfPresent(warpFisheye, forKey: .warpFisheye)
        try container.encodeIfPresent(fixVignetteRadial, forKey: .fixVignetteRadial)

        try container.encodeIfPresent(makerNoteSafety, forKey: .makerNoteSafety)
        try container.encodeIfPresent(privateData?.count, forKey: .privateData)
    }
}
