public import Foundation
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
    public let urgency: String?

    /// The subject reference.
    ///
    /// Specifies one or more Subjects from the IPTC Subject-NewsCodes taxonomy to categorize the image. Each Subject is represented as a string of 8 digits in an unordered list.
    ///
    /// [7.23. Subject Code (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#subject-code-legacy)
    public let subjectReference: String?

    /// The category.
    ///
    /// As this metadata element was earmarked as deprecated already for IIM 4.1,
    /// it was not adopted. However, this data is still synchronized with the XMP
    ///  property “photoshop:Category”, and hence available for future use – but
    ///  outside the IPTC Core.
    ///
    /// [9.1. _Deprecated_ IIM metadata rawValue](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#deprecated-iim-metadata-rawValue)
    public let category: String?

    /// A supplemental category.
    public let supplementalCategory: String?

    /// A fixture identifier.
    public let fixtureIdentifier: String?

    /// Keywords relevant to the image.
    ///
    /// [7.18. Keywords](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#keywords)
    public let keywords: [String]?

    /// The content location code.
    public let contentLocationCode: String?

    /// The content location name.
    public let contentLocationName: String?

    /// The edit status.
    public let editStatus: String?

    /// An editorial update.
    public let editorialUpdate: String?

    public let objectCycle: String?

    // MARK: - Image Information

    /// The image type.
    public let imageType: String?

    /// The image orientation (portrait, landscape, or square).
    public let imageOrientation: String?

    /// The language identifier.
    ///
    /// A two-letter code defined by [ISO 639:1988](https://en.wikipedia.org/wiki/List_of_ISO_639_language_codes).
    public let languageIdentifier: String?

    /// The description of the image.
    ///
    /// [7.11. Description](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#description)
    public let captionAbstract: String?

    /// A summary of the contents of the image.
    ///
    /// A brief synopsis of the caption. Headline is not the same as Title.
    ///
    /// [7.14. Headline](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#headline)
    public let headline: String?

    /// The name of the service that provided the image.
    ///
    /// The credit to person(s) and/or organization(s) required by the supplier of the image to be used when published.
    ///
    /// [7.9. Credit Line](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#credit-line)
    public let creditLine: String?

    /// The star rating.
    public let starRating: String?

    /// The scene codes for the image; a scene code is a six-digit string.
    public let sceneCodes: [IPTC.NewsCode.Scene]?

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
    public let copyrightNotice: String?

    /// The usage rights for the image.
    ///
    /// [7.20. Rights Usage Terms](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#rights-usage-terms)
    public let rightsUsageTerms: String?

    // MARK: - Release Information

    /// The earliest date and time on which you can use the image.
    public let releaseDate: Date?

    /// The latest date you can use the image.
    public let expirationDate: Date?

    /// Special instructions about the use of the image.
    public let specialInstructions: String?

    /// The advised action.
    public let actionAdvised: String?

    /// The reference service.
    public let referenceService: String?

    /// The reference date.
    public let referenceDate: String?
    // FIXME: ^^^ should be a date

    /// The reference number.
    public let referenceNumber: String?

    /// The date the image was originally created.
    public let creationDate: Date?

    /// The date the image was digitized.
    public let digitalCreationDate: Date?

    // MARK: - Personnel

    /// The name of the person who created the image.
    public let byline: [String]?
    // FIXME: Is this really an array?

    /// The title of the person who created the image.
    public let bylineTitle: String?

    /// The original owner of the image.
    public let source: String?

    /// The contact information for getting details about the image.
    public let contact: String?

    /// The name of the person who wrote or edited the description of the image.
    public let writerEditor: String?

    /// The creator’s contact info.
    public let creatorContactInfo: [IPTC.CreatorContactKey: String]?

    // MARK: - Location data

    /// The city where the image was created.
    ///
    /// [7.2. City (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#city-legacy)
    public let city: String?

    /// The location within the city where the image was created.
    ///
    /// [7.24. Sublocation (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#sublocation-legacy)
    public let subLocation: String?

    /// The province or state.
    ///
    /// Name of the subregion of a country of the location shown in the image.
    ///
    /// [7.19. Province or State (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#province-or-state-legacy)
    public let provinceState: String?

    /// The primary country code.
    ///
    /// A three-letter code defined by [ISO 3166-1](https://en.wikipedia.org/wiki/ISO_3166-1).
    ///
    /// [7.5. Country Code (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#country-code-legacy)
    public let countryCode: String?

    /// The primary country name.
    ///
    /// [7.4. Country (legacy)](https://www.iptc.org/std/photometadata/specification/IPTC-PhotoMetadata#country-legacy)
    public let country: String?

    /// The call letter or number combination associated with the originating point of an image.
    public let originalTransmissionReference: String?

    // MARK: - Software Program

    /// The originating application.
    public let originatingProgram: String?

    /// The application version.
    public let programVersion: String?

    // MARK: - Object Details

    /// The object type.
    public let objectType: String?

    /// The object attribute.
    public let objectAttribute: String?

    /// The object name.
    public let objectName: String?

    public init(rawValue: NSDictionary) {
        // Image Categorization
        self.urgency = rawValue[kCGImagePropertyIPTCUrgency] as? String
        self.subjectReference = rawValue[kCGImagePropertyIPTCSubjectReference] as? String
        self.category = rawValue[kCGImagePropertyIPTCCategory] as? String
        self.supplementalCategory = rawValue[kCGImagePropertyIPTCSupplementalCategory] as? String
        self.fixtureIdentifier = rawValue[kCGImagePropertyIPTCFixtureIdentifier] as? String
        if let kws = rawValue[kCGImagePropertyIPTCKeywords] as? [String] {
            let nonEmpty = kws.filter { $0.isEmpty == false }
            self.keywords = nonEmpty.isEmpty ? nil : kws
        } else {
            self.keywords = nil
        }
        self.contentLocationCode = rawValue[kCGImagePropertyIPTCContentLocationCode] as? String
        self.contentLocationName = rawValue[kCGImagePropertyIPTCContentLocationName] as? String
        self.editStatus = rawValue[kCGImagePropertyIPTCEditStatus] as? String
        self.editorialUpdate = rawValue[kCGImagePropertyIPTCEditorialUpdate] as? String
        self.objectCycle = rawValue[kCGImagePropertyIPTCObjectCycle] as? String

        // Image Information
        self.imageType = rawValue[kCGImagePropertyIPTCImageType] as? String
        self.imageOrientation = rawValue[kCGImagePropertyIPTCImageOrientation] as? String
        self.languageIdentifier = rawValue[kCGImagePropertyIPTCLanguageIdentifier] as? String
        self.captionAbstract = rawValue[kCGImagePropertyIPTCCaptionAbstract] as? String
        self.headline = rawValue[kCGImagePropertyIPTCHeadline] as? String
        self.creditLine = rawValue[kCGImagePropertyIPTCCredit] as? String
        self.starRating = rawValue[kCGImagePropertyIPTCStarRating] as? String
        if let values = rawValue[kCGImagePropertyIPTCScene] as? [String] {
            let scenes = values.compactMap { IPTC.NewsCode.Scene(rawValue: $0) }
            self.sceneCodes = scenes.isEmpty ? nil : scenes
        } else {
            self.sceneCodes = nil
        }

        // Copyright
        self.copyrightNotice = rawValue[kCGImagePropertyIPTCCopyrightNotice] as? String
        self.rightsUsageTerms = rawValue[kCGImagePropertyIPTCRightsUsageTerms] as? String

        // Release Information
        if
            let dateString = rawValue[kCGImagePropertyIPTCReleaseDate] as? String,
            let timeString = rawValue[kCGImagePropertyIPTCReleaseDate] as? String
        {
            self.releaseDate = Self.releaseDateFormatter.date(from: "\(dateString) \(timeString)")
        } else {
            self.releaseDate = nil
        }
        if
            let dateString = rawValue[kCGImagePropertyIPTCExpirationDate] as? String,
            let timeString = rawValue[kCGImagePropertyIPTCExpirationDate] as? String
        {
            self.expirationDate = Self.releaseDateFormatter.date(from: "\(dateString) \(timeString)")
        } else {
            self.expirationDate = nil
        }
        self.specialInstructions = rawValue[kCGImagePropertyIPTCSpecialInstructions] as? String
        self.actionAdvised = rawValue[kCGImagePropertyIPTCActionAdvised] as? String
        self.referenceService = rawValue[kCGImagePropertyIPTCReferenceService] as? String
        self.referenceDate = rawValue[kCGImagePropertyIPTCReferenceDate] as? String
        self.referenceNumber = rawValue[kCGImagePropertyIPTCReferenceNumber] as? String

        // Creation Dates
        if
            let dateString = rawValue[kCGImagePropertyIPTCDateCreated] as? String,
            let timeString = rawValue[kCGImagePropertyIPTCTimeCreated] as? String
        {
            self.creationDate = Self.dateFormatter.date(from: "\(dateString) \(timeString)")
        } else {
            self.creationDate = nil
        }
        if
            let dateString = rawValue[kCGImagePropertyIPTCDigitalCreationDate] as? String,
            let timeString = rawValue[kCGImagePropertyIPTCDigitalCreationTime] as? String
        {
            self.digitalCreationDate = Self.dateFormatter.date(from: "\(dateString) \(timeString)")
        } else {
            self.digitalCreationDate = nil
        }

        // Personnel
        self.byline = rawValue[kCGImagePropertyIPTCByline] as? [String]
        self.bylineTitle = rawValue[kCGImagePropertyIPTCBylineTitle] as? String
        self.source = rawValue[kCGImagePropertyIPTCSource] as? String
        self.contact = rawValue[kCGImagePropertyIPTCContact] as? String
        self.writerEditor = rawValue[kCGImagePropertyIPTCWriterEditor] as? String
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

        // Location data
        self.city = rawValue[kCGImagePropertyIPTCCity] as? String
        self.subLocation = rawValue[kCGImagePropertyIPTCSubLocation] as? String
        self.provinceState = rawValue[kCGImagePropertyIPTCProvinceState] as? String
        self.countryCode = rawValue[kCGImagePropertyIPTCCountryPrimaryLocationCode] as? String
        self.country = rawValue[kCGImagePropertyIPTCCountryPrimaryLocationName] as? String
        self.originalTransmissionReference = rawValue[kCGImagePropertyIPTCOriginalTransmissionReference] as? String

        // Software Program
        self.originatingProgram = rawValue[kCGImagePropertyIPTCOriginatingProgram] as? String
        self.programVersion = rawValue[kCGImagePropertyIPTCProgramVersion] as? String

        // Object Details
        self.objectType = rawValue[kCGImagePropertyIPTCObjectTypeReference] as? String
        self.objectAttribute = rawValue[kCGImagePropertyIPTCObjectAttributeReference] as? String
        self.objectName = rawValue[kCGImagePropertyIPTCObjectName] as? String
    }

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

