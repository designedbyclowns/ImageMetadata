public import Foundation
import ImageIO

/// Metadata defined by the International Press Telecommunications Council (IPTC) data.
///
/// IPTC constants are metadata elements of the Information Interchange Model (IIM) used to provide information about images.
/// The IIM was developed by the Newspaper Association of America (NAA) and the [IPTC](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#metadata-properties).
public struct IPTC: Metadata {

    /// The advised action.
    public let actionAdvised: String?

    /// The name of the person who created the image.
    public let byline: [String]?
    // FIXME: Is this really an array?

    /// The title of the person who created the image.
    public let bylineTitle: String?

    /// The description of the image.
    ///
    /// [7.11. Description](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#description)
    public let captionAbstract: String?

    /// The category.
    ///
    /// As this metadata element was earmarked as deprecated already for IIM 4.1,
    /// it was not adopted. However, this data is still synchronized with the XMP
    ///  property “photoshop:Category”, and hence available for future use – but
    ///  outside the IPTC Core.
    ///
    /// [9.1. _Deprecated_ IIM metadata rawValue](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#deprecated-iim-metadata-rawValue)
    public let category: String?

    /// The city where the image was created.
    ///
    /// [7.2. City (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#city-legacy)
    public let city: String?

    /// The contact information for getting details about the image.
    public let contact: String?

    /// The primary country name.
    ///
    /// [7.4. Country (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#country-legacy)
    public let country: String?

    /// The primary country code.
    ///
    /// A three-letter code defined by [ISO 3166-1](https://en.wikipedia.org/wiki/ISO_3166-1).
    ///
    /// [7.5. Country Code (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#country-code-legacy)
    public let countryCode: String?

    /// The date the image was originally created.
    public let creationDate: Date?

    /// The credit to person(s) and/or organization(s) required by the supplier of the image to be used when published.
    ///
    /// [7.9. Credit Line](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#credit-line)
    public let creditLine: String?

    /// The creator’s contact info.
    public let creatorContactInfo: [IPTC.CreatorContactKey: String]?

    /// The date the image was digitized.
    public let digitalCreationDate: Date?

    /// The edit status.
    public let editStatus: String?

    /// An editorial update.
    public let editorialUpdate: String?

    /// The earliest date and time on which you can use the image.
    public let expirationDate: Date?

    /// A fixture identifier.
    public let fixtureIdentifier: String?

    /// The headline is a summary of the contents of the image.
    ///
    /// A brief synopsis of the caption. Headline is not the same as Title.
    ///
    /// [7.14. Headline](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#headline)
    public let headline: String?

    /// The image orientation (portrait, landscape, or square).
    public let imageOrientation: String?

    /// The image type.
    public let imageType: String?

    /// Keywords relevant to the image.
    ///
    /// [7.18. Keywords](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#keywords)
    public let keywords: [String]?

    /// The language identifier.
    ///
    /// A two-letter code defined by [ISO 639:1988](https://en.wikipedia.org/wiki/List_of_ISO_639_language_codes).
    public let languageIdentifier: String?

    /// The object attribute.
    public let objectAttribute: String?

    /// The subject reference.
    ///
    /// Specifies one or more Subjects from the IPTC Subject-NewsCodes taxonomy to categorize the image. Each Subject is represented as a string of 8 digits in an unordered list.
    ///
    /// [7.23. Subject Code (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#subject-code-legacy)
    public let objectCycle: String?

    /// The object name.
    public let objectName: String?

    /// The object type.
    public let objectType: String?

    /// The originating application.
    public let originatingProgram: String?

    /// The call letter or number combination associated with the originating point of an image.
    public let originalTransmissionReference: String?

    /// The content location code.
    public let contentLocationCode: String?

    /// The content location name.
    public let contentLocationName: String?
    
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
    public let copyrightNotice: String?

    /// The program version.
    public let programVersion: String?

    /// The province or state.
    ///
    /// Name of the subregion of a country of the location shown in the image.
    ///
    /// [7.19. Province or State (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#province-or-state-legacy)
    public let provinceState: String?

    /// The reference date.
    public let referenceDate: Date?

    /// The reference number.
    public let referenceNumber: String?

    /// The reference service.
    public let referenceService: String?

    /// The earliest date and time on which you can use the image.
    public let releaseDate: Date?

    /// The usage rights for the image.
    ///
    /// [7.20. Rights Usage Terms](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#rights-usage-terms)
    public let rightsUsageTerms: String?

    /// The scene codes for the image; a scene code is a six-digit string.
    public let sceneCodes: [IPTC.NewsCode.Scene]?

    /// The original owner of the image.
    public let source: String?

    /// The star rating.
    public let starRating: String?

    /// Special instructions about the use of the image.
    public let specialInstructions: String?

    /// The location within the city where the image was created.
    ///
    /// [7.24. Sublocation (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#sublocation-legacy)
    public let subLocation: String?

    /// A supplemental category.
    public let supplementalCategory: String?

    /// The subject reference.
    ///
    /// Specifies one or more Subjects from the IPTC Subject-NewsCodes taxonomy to categorize the image. Each Subject is represented as a string of 8 digits in an unordered list.
    ///
    /// [7.23. Subject Code (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#subject-code-legacy)
    public let subjectReference: String?

    /// The urgency level.
    ///
    /// As this metadata element pertains to distribution management, it was not adopted.
    /// However, this data is still synchronized with the XMP property `photoshop:Urgency`, and hence, available for future use, but outside
    /// the IPTC Core.
    ///
    /// [9.1. _Deprecated_ IIM metadata rawValue](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#deprecated-iim-metadata-rawValue)
    public let urgency: String?

    /// The name of the person who wrote or edited the description of the image.
    public let writerEditor: String?

    
    public init(rawValue: NSDictionary) {
        let dateParseStrategy = Date.VerbatimFormatStyle(
            format: "\(year: .defaultDigits)\(month: .twoDigits)\(day: .twoDigits) \(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .oneBased))\(minute: .twoDigits)\(second: .twoDigits)",
            locale: Locale(identifier: "en_US"),
            // IPTC date and time data provides no offset or time zone info so assume local.
            timeZone: .current,
            calendar: .gregorian
        ).parseStrategy
        
        func parse(dateString: String?, timeString: String?) -> Date? {
            guard let dateString else { return nil }
            let time = timeString ?? "000000"
            return try? dateParseStrategy.parse("\(dateString) \(time)")
        }
        
        self.actionAdvised = rawValue[kCGImagePropertyIPTCActionAdvised] as? String
        self.byline = rawValue[kCGImagePropertyIPTCByline] as? [String]
        self.bylineTitle = rawValue[kCGImagePropertyIPTCBylineTitle] as? String
        self.captionAbstract = rawValue[kCGImagePropertyIPTCCaptionAbstract] as? String
        self.category = rawValue[kCGImagePropertyIPTCCategory] as? String
        self.city = rawValue[kCGImagePropertyIPTCCity] as? String
        self.contact = rawValue[kCGImagePropertyIPTCContact] as? String
        self.contentLocationCode = rawValue[kCGImagePropertyIPTCContentLocationCode] as? String
        self.contentLocationName = rawValue[kCGImagePropertyIPTCContentLocationName] as? String
        self.copyrightNotice = rawValue[kCGImagePropertyIPTCCopyrightNotice] as? String
        self.country = rawValue[kCGImagePropertyIPTCCountryPrimaryLocationName] as? String
        self.countryCode = rawValue[kCGImagePropertyIPTCCountryPrimaryLocationCode] as? String
        
        if let dict = rawValue[kCGImagePropertyIPTCCreatorContactInfo] as? NSDictionary {
            let info = dict.reduce(into: [IPTC.CreatorContactKey: String]()) { partialResult, element in
                guard
                    let strKey = element.key as? String,
                    let key = IPTC.CreatorContactKey(rawValue: strKey)
                else {
                    return
                }
                partialResult[key] = element.value as? String
            }
            self.creatorContactInfo = info.isEmpty ? nil : info
        } else {
            self.creatorContactInfo = nil
        }
        
        self.creationDate = parse(
            dateString: rawValue[kCGImagePropertyIPTCDateCreated] as? String,
            timeString: rawValue[kCGImagePropertyIPTCTimeCreated] as? String
        )
        self.creditLine = rawValue[kCGImagePropertyIPTCCredit] as? String
        self.digitalCreationDate = parse(
            dateString: rawValue[kCGImagePropertyIPTCDigitalCreationDate] as? String,
            timeString: rawValue[kCGImagePropertyIPTCDigitalCreationTime] as? String
        )
        self.editorialUpdate = rawValue[kCGImagePropertyIPTCEditorialUpdate] as? String
        self.editStatus = rawValue[kCGImagePropertyIPTCEditStatus] as? String
        self.expirationDate = parse(
            dateString: rawValue[kCGImagePropertyIPTCExpirationDate] as? String,
            timeString: rawValue[kCGImagePropertyIPTCExpirationTime] as? String
        )
        self.fixtureIdentifier = rawValue[kCGImagePropertyIPTCFixtureIdentifier] as? String
        self.headline = rawValue[kCGImagePropertyIPTCHeadline] as? String
        self.imageOrientation = rawValue[kCGImagePropertyIPTCImageOrientation] as? String
        self.imageType = rawValue[kCGImagePropertyIPTCImageType] as? String
        self.keywords = rawValue[kCGImagePropertyIPTCKeywords] as? [String]
        self.languageIdentifier = rawValue[kCGImagePropertyIPTCLanguageIdentifier] as? String
        self.objectAttribute = rawValue[kCGImagePropertyIPTCObjectAttributeReference] as? String
        self.objectCycle = rawValue[kCGImagePropertyIPTCObjectCycle] as? String
        self.objectName = rawValue[kCGImagePropertyIPTCObjectName] as? String
        self.objectType = rawValue[kCGImagePropertyIPTCObjectTypeReference] as? String
        self.originalTransmissionReference = rawValue[kCGImagePropertyIPTCOriginalTransmissionReference] as? String
        self.originatingProgram = rawValue[kCGImagePropertyIPTCOriginatingProgram] as? String
        self.programVersion = rawValue[kCGImagePropertyIPTCProgramVersion] as? String
        self.provinceState = rawValue[kCGImagePropertyIPTCProvinceState] as? String
        
        self.referenceDate = (rawValue[kCGImagePropertyIPTCReferenceDate] as? String)
            .map({ try? dateParseStrategy.parse($0) }) ?? nil
        
        self.referenceNumber = rawValue[kCGImagePropertyIPTCReferenceNumber] as? String
        self.referenceService = rawValue[kCGImagePropertyIPTCReferenceService] as? String
        self.releaseDate = parse(
            dateString: rawValue[kCGImagePropertyIPTCReleaseDate] as? String,
            timeString: rawValue[kCGImagePropertyIPTCReleaseTime] as? String
        )
        self.rightsUsageTerms = rawValue[kCGImagePropertyIPTCRightsUsageTerms] as? String
        
        let scenes = (rawValue[kCGImagePropertyIPTCScene] as? [String])?.compactMap({ IPTC.NewsCode.Scene(rawValue: $0) }) ?? []
        self.sceneCodes = scenes.isEmpty ? nil : scenes
        
        self.source = rawValue[kCGImagePropertyIPTCSource] as? String
        self.specialInstructions = rawValue[kCGImagePropertyIPTCSpecialInstructions] as? String
        self.starRating = rawValue[kCGImagePropertyIPTCStarRating] as? String
        self.subjectReference = rawValue[kCGImagePropertyIPTCSubjectReference] as? String
        self.subLocation = rawValue[kCGImagePropertyIPTCSubLocation] as? String
        self.supplementalCategory = rawValue[kCGImagePropertyIPTCSupplementalCategory] as? String
        self.urgency = rawValue[kCGImagePropertyIPTCUrgency] as? String
        self.writerEditor = rawValue[kCGImagePropertyIPTCWriterEditor] as? String
    }
}

