import Foundation

extension IPTC: Encodable {
    enum CodingKeys: String, CodingKey {
        case actionAdvised
        case byline
        case bylineTitle
        case captionAbstract
        case category
        case city
        case contact
        case contentLocationCode
        case contentLocationName
        case copyrightNotice
        case country
        case countryCode
        case creationDate
        case creatorContactInfo
        case creditLine
        case digitalCreationDate
        case editorialUpdate
        case editStatus
        case expirationDate
        case fixtureIdentifier
        case headline
        case imageOrientation
        case imageType
        case keywords
        case languageIdentifier
        case objectAttribute
        case objectCycle
        case objectName
        case objectType
        case originalTransmissionReference
        case originatingProgram
        case programVersion
        case provinceState
        case referenceDate
        case referenceNumber
        case referenceService
        case releaseDate
        case rightsUsageTerms
        case sceneCodes
        case source
        case specialInstructions
        case starRating
        case subjectReference
        case subLocation
        case supplementalCategory
        case urgency
        case writerEditor
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(actionAdvised, forKey: .actionAdvised)
        try container.encodeIfPresent(byline, forKey: .byline)
        try container.encodeIfPresent(bylineTitle, forKey: .bylineTitle)
        try container.encodeIfPresent(captionAbstract, forKey: .captionAbstract)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(contact, forKey: .contact)
        try container.encodeIfPresent(contentLocationCode, forKey: .contentLocationCode)
        try container.encodeIfPresent(contentLocationName, forKey: .contentLocationName)
        try container.encodeIfPresent(copyrightNotice, forKey: .copyrightNotice)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(countryCode, forKey: .countryCode)
        try container.encodeIfPresent(creationDate, forKey: .creationDate)
        try container.encodeIfPresent(creatorContactInfo, forKey: .creatorContactInfo)
        try container.encodeIfPresent(creditLine, forKey: .creditLine)
        try container.encodeIfPresent(digitalCreationDate, forKey: .digitalCreationDate)
        try container.encodeIfPresent(editorialUpdate, forKey: .editorialUpdate)
        try container.encodeIfPresent(editStatus, forKey: .editStatus)
        try container.encodeIfPresent(expirationDate, forKey: .expirationDate)
        try container.encodeIfPresent(fixtureIdentifier, forKey: .fixtureIdentifier)
        try container.encodeIfPresent(headline, forKey: .headline)
        try container.encodeIfPresent(imageOrientation, forKey: .imageOrientation)
        try container.encodeIfPresent(imageType, forKey: .imageType)
        try container.encodeIfPresent(keywords, forKey: .keywords)
        try container.encodeIfPresent(languageIdentifier, forKey: .languageIdentifier)
        try container.encodeIfPresent(objectAttribute, forKey: .objectAttribute)
        try container.encodeIfPresent(objectCycle, forKey: .objectCycle)
        try container.encodeIfPresent(objectName, forKey: .objectName)
        try container.encodeIfPresent(objectType, forKey: .objectType)
        try container.encodeIfPresent(originalTransmissionReference, forKey: .originalTransmissionReference)
        try container.encodeIfPresent(originatingProgram, forKey: .originatingProgram)
        try container.encodeIfPresent(programVersion, forKey: .programVersion)
        try container.encodeIfPresent(provinceState, forKey: .provinceState)
        try container.encodeIfPresent(referenceDate, forKey: .referenceDate)
        try container.encodeIfPresent(referenceNumber, forKey: .referenceNumber)
        try container.encodeIfPresent(referenceService, forKey: .referenceService)
        try container.encodeIfPresent(releaseDate, forKey: .releaseDate)
        try container.encodeIfPresent(rightsUsageTerms, forKey: .rightsUsageTerms)
        try container.encodeIfPresent(sceneCodes, forKey: .sceneCodes)
        try container.encodeIfPresent(source, forKey: .source)
        try container.encodeIfPresent(specialInstructions, forKey: .specialInstructions)
        try container.encodeIfPresent(starRating, forKey: .starRating)
        try container.encodeIfPresent(subjectReference, forKey: .subjectReference)
        try container.encodeIfPresent(subLocation, forKey: .subLocation)
        try container.encodeIfPresent(supplementalCategory, forKey: .supplementalCategory)
        try container.encodeIfPresent(urgency, forKey: .urgency)
        try container.encodeIfPresent(writerEditor, forKey: .writerEditor)
    }
}
