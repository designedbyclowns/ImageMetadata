import Foundation

public enum MetadataError: Error {
    case invalidImageProperties
    case invalidImageSource
    case keyNotFound(String)
}


extension MetadataError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .keyNotFound(let key):
            return String(localized: "key not found '\(key)').")
        case .invalidImageProperties:
            return String(localized: "Failed to read image properties.")
        case .invalidImageSource:
            return String(localized: "Failed to read image source.")
        }
    }
}
