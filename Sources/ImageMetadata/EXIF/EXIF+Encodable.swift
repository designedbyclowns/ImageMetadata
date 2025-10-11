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
        try container.encodeIfPresent(colorSpace?.description, forKey: .colorSpace)
        try container.encodeIfPresent(componentsConfiguration, forKey: .componentsConfiguration)
        try container.encodeIfPresent(compositeImage?.description, forKey: .compositeImage)
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
