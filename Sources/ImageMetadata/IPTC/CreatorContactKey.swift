import Foundation

public extension IPTC {
    enum CreatorContactKey: String, Codable {
        case contactInfoAddress = "kCGImagePropertyIPTCContactInfoAddress"
        case contactInfoCity = "kCGImagePropertyIPTCContactInfoCity"
        case contactInfoCountry = "kCGImagePropertyIPTCContactInfoCountry"
        case contactInfoEmails = "kCGImagePropertyIPTCContactInfoEmails"
        case contactInfoPhones = "kCGImagePropertyIPTCContactInfoPhones"
        case contactInfoPostalCode = "kCGImagePropertyIPTCContactInfoPostalCode"
        case contactInfoStateProvince = "kCGImagePropertyIPTCContactInfoStateProvince"
        case contactInfoWebURLs = "kCGImagePropertyIPTCContactInfoWebURLs"
    }
}

extension IPTC.CreatorContactKey: CustomStringConvertible {
    public var description: String {
        switch self {
        case .contactInfoAddress:
            String(localized: "The address portion of the contact information.")
        case .contactInfoCity:
            String(localized: "The city portion of the contact information.")
        case .contactInfoCountry:
            String(localized: "The country or region portion of the contact information.")
        case .contactInfoEmails:
            String(localized: "Email addresses for the contact.")
        case .contactInfoPhones:
            String(localized: "Phone numbers for the contact.")
        case .contactInfoPostalCode:
            String(localized: "The postal code portion of the contact.")
        case .contactInfoStateProvince:
            String(localized: "The state or province of the contact.")
        case .contactInfoWebURLs:
            String(localized: "Web addresses for the contact.")
        }
    }
}
