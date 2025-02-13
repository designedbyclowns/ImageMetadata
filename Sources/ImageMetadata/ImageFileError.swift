import Foundation

public struct ImageFileError: Error {
    enum Code: Int {
        case accessDenied
        case invalidContentType
        case invalidURL
        case noSuchFile
        case unknown
    }
    
    let url: URL
    let code: Code
    let underlyingError: Error?
    
    init(_ url: URL, code: Code = .unknown, underlyingError: Error? = nil) {
        self.url = url
        self.code = code
        self.underlyingError = underlyingError
    }
}

extension ImageFileError: Equatable {
    public static func == (lhs: ImageFileError, rhs: ImageFileError) -> Bool {
        guard lhs.code != .unknown || rhs.code != .unknown else {
            return false
        }
        return lhs.url == rhs.url && lhs.code == rhs.code
    }
}

extension ImageFileError: LocalizedError {
    public var errorDescription: String? {
        switch code {
        case .accessDenied:
            return String(localized: "Cannot access \(url.absoluteString)")
        case .invalidURL:
            return String(localized: "\(url.absoluteString) is not a file URL.")
        case .invalidContentType:
            return String(localized: "Invalid content type.")
        case .noSuchFile:
            if let underlyingError {
                return underlyingError.localizedDescription
            } else {
                return String(localized: "The file '\(url.absoluteString)' couldn’t be opened because it doesn’t exist.")
            }
        case .unknown:
            if let underlyingError {
                return underlyingError.localizedDescription
            } else {
                return String(localized: "An unknown error occurred.")
            }
        }
    }
    
    public var recoverySuggestion: String? {
        switch code {
        case .accessDenied:
            return String(localized: "Please select a file you have permission to access.")
        case .invalidURL:
            return String(localized: "Please select a valid file.")
        case .invalidContentType:
            return String(localized: "Please select an image file.")
        default:
            guard let underlyingError else { return nil }
            return (underlyingError as NSError).localizedRecoverySuggestion
        }
    }
}

extension ImageFileError: CustomNSError {
    public static var errorDomain: String { "com.designedbyclowns.ImageMD" }

    public var errorCode: Int { code.rawValue }

    public var errorUserInfo: [String : Any] {
        var info = [String : Any]()
        info[NSURLErrorFailingURLStringErrorKey] = url.absoluteString
        info[NSUnderlyingErrorKey] = underlyingError
        return info
    }
}
