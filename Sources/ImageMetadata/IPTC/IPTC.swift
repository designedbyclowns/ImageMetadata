import Foundation
import ImageIO

/// Metadata defined by the International Press Telecommunications Council (IPTC) data.
///
/// IPTC constants are metadata elements of the Information Interchange Model (IIM) used to provide information about images.
/// The IIM was developed by the Newspaper Association of America (NAA) and the [IPTC](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#metadata-properties).
public struct IPTC: Metadata {
        
    // MARK: - Image Categorization
    
    /// The urgency level.
    ///
    /// As this metadata element pertains to distribution management, it was not adopted.
    /// However, this data is still synchronized with the XMP property `photoshop:Urgency`, and hence, available for future use, but outside
    /// the IPTC Core.
    ///
    /// [9.1. _Deprecated_ IIM metadata rawValue](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#deprecated-iim-metadata-rawValue)
    public var urgency: String? {
        rawValue[kCGImagePropertyIPTCUrgency] as? String
    }
    
    /// The subject reference.
    ///
    /// Specifies one or more Subjects from the IPTC Subject-NewsCodes taxonomy to categorize the image. Each Subject is represented as a string of 8 digits in an unordered list.
    ///
    /// [7.23. Subject Code (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#subject-code-legacy)
    public var subjectReference: String? {
        rawValue[kCGImagePropertyIPTCSubjectReference] as? String
    }
    
    /// The category.
    ///
    /// As this metadata element was earmarked as deprecated already for IIM 4.1,
    /// it was not adopted. However, this data is still synchronized with the XMP
    ///  property “photoshop:Category”, and hence available for future use – but
    ///  outside the IPTC Core.
    ///
    /// [9.1. _Deprecated_ IIM metadata rawValue](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#deprecated-iim-metadata-rawValue)
    public var category: String? {
        rawValue[kCGImagePropertyIPTCCategory] as? String
    }
    
    /// A supplemental category.
    public var supplementalCategory: String? {
        rawValue[kCGImagePropertyIPTCSupplementalCategory] as? String
    }
    
    /// A fixture identifier.
    public var fixtureIdentifier: String? {
        rawValue[kCGImagePropertyIPTCFixtureIdentifier] as? String
    }
    
    /// Keywords relevant to the image.
    ///
    /// [7.18. Keywords](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#keywords)
    public var keywords: [String]? {
        guard let keywords = rawValue[kCGImagePropertyIPTCKeywords] as? [String] else { return nil }
        return keywords.filter({ $0.isEmpty == false}).isEmpty ? nil : keywords
    }
    
    /// The content location code.
    public var contentLocationCode: String? {
        rawValue[kCGImagePropertyIPTCContentLocationCode] as? String
    }
    
    /// The content location name.
    public var contentLocationName: String? {
        rawValue[kCGImagePropertyIPTCContentLocationName] as? String
    }
    
    /// The edit status.
    public var editStatus: String? {
        rawValue[kCGImagePropertyIPTCEditStatus] as? String
    }
    
    /// An editorial update.
    public var editorialUpdate: String? {
        rawValue[kCGImagePropertyIPTCEditorialUpdate] as? String
    }
    
    public var objectCycle: String? {
        rawValue[kCGImagePropertyIPTCObjectCycle] as? String
    }
    
    // MARK: - Image Information
    
    /// The image type.
    public var imageType: String? {
        rawValue[kCGImagePropertyIPTCImageType] as? String
    }
    
    /// The image orientation (portrait, landscape, or square).
    public var imageOrientation: String? {
        rawValue[kCGImagePropertyIPTCImageOrientation] as? String
    }
    
    /// The language identifier.
    ///
    /// A two-letter code defined by [ISO 639:1988](https://en.wikipedia.org/wiki/List_of_ISO_639_language_codes).
    public var languageIdentifier: String? {
        rawValue[kCGImagePropertyIPTCLanguageIdentifier] as? String
    }
    
    /// The description of the image.
    ///
    /// [7.11. Description](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#description)
    public var captionAbstract: String? {
        rawValue[kCGImagePropertyIPTCCaptionAbstract] as? String
    }
    
    /// A summary of the contents of the image.
    ///
    /// A brief synopsis of the caption. Headline is not the same as Title.
    ///
    /// [7.14. Headline](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#headline)
    public var headline: String? {
        rawValue[kCGImagePropertyIPTCHeadline] as? String
    }
    
    /// The name of the service that provided the image.
    ///
    /// The credit to person(s) and/or organization(s) required by the supplier of the image to be used when published.
    ///
    /// [7.9. Credit Line](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#credit-line)
    public var creditLine: String? {
        rawValue[kCGImagePropertyIPTCCredit] as? String
    }
    
    /// The star rating.
    public var starRating: String? {
        rawValue[kCGImagePropertyIPTCStarRating] as? String
    }
    
    /// The scene codes for the image; a scene code is a six-digit string.
    public var sceneCodes: [IPTC.NewsCode.Scene]? {
        guard let values = rawValue[kCGImagePropertyIPTCScene] as? [String] else { return nil }
        let sceneCodes = values.compactMap { IPTC.NewsCode.Scene(rawValue: $0) }
        return sceneCodes.isEmpty ? nil : sceneCodes
    }
    
    // MARK: - Copyright
    
    /// The copyright notice.
    ///
    /// Contains any necessary copyright notice for claiming the intellectual
    /// property for this photograph and should identify the current owner of
    /// the copyright for the photograph. Other entities like the creator of
    /// the photograph may be added in the corresponding field.
    ///
    ///  Notes on usage rights should be provided in ``rightsUsageTerms``.
    ///
    ///  [7.3. Copyright Notice](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#copyright-notice)
    public var copyrightNotice: String? {
        rawValue[kCGImagePropertyIPTCCopyrightNotice] as? String
    }
    
    /// The usage rights for the image.
    ///
    /// [7.20. Rights Usage Terms](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#rights-usage-terms)
    public var rightsUsageTerms: String? {
        rawValue[kCGImagePropertyIPTCRightsUsageTerms] as? String
    }
    
    // MARK: - Release Information
    
    /// The earliest date and time on which you can use the image.
    public var releaseDate: Date? {
        guard
            let dateString = rawValue[kCGImagePropertyIPTCReleaseDate] as? String,
            let timeString = rawValue[kCGImagePropertyIPTCReleaseDate] as? String
        else {
            return nil
        }
        return Self.releaseDateFormatter.date(from: "\(dateString) \(timeString)")
    }
        
    /// The latest date you can use the image.
    public var expirationDate: Date? {
        guard
            let dateString = rawValue[kCGImagePropertyIPTCExpirationDate] as? String,
            let timeString = rawValue[kCGImagePropertyIPTCExpirationDate] as? String
        else {
            return nil
        }
        return Self.releaseDateFormatter.date(from: "\(dateString) \(timeString)")
    }
    
    /// Special instructions about the use of the image.
    public var specialInstructions: String? {
        rawValue[kCGImagePropertyIPTCSpecialInstructions] as? String
    }
    
    /// The advised action.
    public var actionAdvised: String? {
        rawValue[kCGImagePropertyIPTCActionAdvised] as? String
    }
    
    /// The reference service.
    public var referenceService: String? {
        rawValue[kCGImagePropertyIPTCReferenceService] as? String
    }
    
    /// The reference date.
    public var referenceDate: String? {
        rawValue[kCGImagePropertyIPTCReferenceDate] as? String
    }
    // FIXME: ^^^ should be a date
    
    /// The reference number.
    public var referenceNumber: String? {
        rawValue[kCGImagePropertyIPTCReferenceNumber] as? String
    }
    
    // The date the image was originally created.
    public var creationDate: Date? {
        guard
            let dateString = rawValue[kCGImagePropertyIPTCDateCreated] as? String,
            let timeString = rawValue[kCGImagePropertyIPTCTimeCreated] as? String
        else {
            return nil
        }
        return Self.dateFormatter.date(from: "\(dateString) \(timeString)")
    }
    
    // The date the image was digitized.
    public var digitalCreationDate: Date? {
        guard
            let dateString = rawValue[kCGImagePropertyIPTCDigitalCreationDate] as? String,
            let timeString = rawValue[kCGImagePropertyIPTCDigitalCreationTime] as? String
        else {
            return nil
        }
        return Self.dateFormatter.date(from: "\(dateString) \(timeString)")
    }
    
    // MARK: - Personnel
    
    /// The name of the person who created the image.
    public var byline: [String]? {
        rawValue[kCGImagePropertyIPTCByline] as? [String]
        // FIXME: Is this really an array?
    }
    
    /// The title of the person who created the image.
    public var bylineTitle: String? {
        rawValue[kCGImagePropertyIPTCBylineTitle] as? String
    }
    
    /// The original owner of the image.
    public var source: String? {
        rawValue[kCGImagePropertyIPTCSource] as? String
    }
    
    /// The contact information for getting details about the image.
    public var contact: String? {
        rawValue[kCGImagePropertyIPTCContact] as? String
    }
    
    /// The name of the person who wrote or edited the description of the image.
    public var writerEditor: String? {
        rawValue[kCGImagePropertyIPTCWriterEditor] as? String
    }
    
    /// The creator’s contact info.
    public var creatorContactInfo: [IPTC.CreatorContactKey: String]? {
        guard let dict = rawValue[kCGImagePropertyIPTCCreatorContactInfo] as? NSDictionary else { return nil }
        
        let info = dict.reduce(into: [IPTC.CreatorContactKey: String]()) { (partialResult, element) in
            guard
                let strKey = element.key as? String,
                let key = IPTC.CreatorContactKey(rawValue: strKey)
            else {
                return
            }
            
            partialResult[key] = element.value as? String
         }
        
        return info.isEmpty ? nil : info
    }
    
    // MARK: - Location data
    
    /// The city where the image was created.
    ///
    /// [7.2. City (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#city-legacy)
    public var city: String? {
        rawValue[kCGImagePropertyIPTCCity] as? String
    }
    
    /// The location within the city where the image was created.
    ///
    /// [7.24. Sublocation (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#sublocation-legacy)
    public var subLocation: String? {
        rawValue[kCGImagePropertyIPTCSubLocation] as? String
    }
    
    /// The province or state.
    ///
    /// Name of the subregion of a country of the location shown in the image.
    ///
    /// [7.19. Province or State (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#province-or-state-legacy)
    public var provinceState: String? {
        rawValue[kCGImagePropertyIPTCProvinceState] as? String
    }
    
    /// The primary country code.
    ///
    /// A three-letter code defined by [ISO 3166-1](https://en.wikipedia.org/wiki/ISO_3166-1).
    ///
    /// [7.5. Country Code (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#country-code-legacy)
    public var countryCode: String? {
        rawValue[kCGImagePropertyIPTCCountryPrimaryLocationCode] as? String
    }
    
    /// The primary country name.
    ///
    /// [7.4. Country (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#country-legacy)
    public var country: String? {
        rawValue[kCGImagePropertyIPTCCountryPrimaryLocationName] as? String
    }
    
    /// The call letter or number combination associated with the originating point of an image.
    public var originalTransmissionReference: String? {
        rawValue[kCGImagePropertyIPTCOriginalTransmissionReference] as? String
    }
    
    // MARK: - Software Program
    
    /// The originating application.
    public var originatingProgram: String? {
        rawValue[kCGImagePropertyIPTCOriginatingProgram] as? String
    }
    
    /// The application version.
    public var programVersion: String? {
        rawValue[kCGImagePropertyIPTCProgramVersion] as? String
    }
    
    // MARK: - Object Details
    
    /// The object type.
    public var objectType: String? {
        rawValue[kCGImagePropertyIPTCObjectTypeReference] as? String
    }
    
    /// The object attribute.
    public var objectAttribute: String? {
        rawValue[kCGImagePropertyIPTCObjectAttributeReference] as? String
    }
    
    /// The object name.
    public var objectName: String? {
        rawValue[kCGImagePropertyIPTCObjectName] as? String
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
        formatter.dateFormat = "yyyyMMdd HHmmss"
        return formatter
    }()
    
    static let releaseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "CCYYMMDD HHMMSS"
        return formatter
    }()
}

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
