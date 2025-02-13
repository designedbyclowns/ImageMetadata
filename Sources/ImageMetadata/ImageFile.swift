import Foundation
import ImageIO
import UniformTypeIdentifiers

/// An image file.
public struct ImageFile {
    /// Creates a new image file from a file path.
    /// - Parameter path: The path to the image file.
    public init(path: String) throws(ImageFileError) {
        try self.init(url: URL(fileURLWithPath: path))
    }
    
    /// Creates a new image file from a file URL.
    /// - Parameter url: The file URL of the image file.
    public init(url: URL) throws(ImageFileError) {
        guard url.isFileURL else {
            throw ImageFileError(url, code: .invalidURL)
        }
        self.url = url
        
        defer {
            // ¡Muy importante! - release access to the URL
            url.stopAccessingSecurityScopedResource()
        }
                
        // gain access to the URL
        let isAccesible = url.startAccessingSecurityScopedResource()
        guard isAccesible else {
            throw ImageFileError(url, code: .accessDenied)
        }
        
        do {
            let resourceValues = try url.resourceValues(forKeys: [.contentTypeKey, .fileSizeKey])
            guard let contentType = resourceValues.contentType, contentType.conforms(to: .image) else {
                throw ImageFileError(url, code: .invalidContentType)
            }
            self.utType = resourceValues.contentType
            self.fileSize = resourceValues.fileSize
                    
        } catch let error as ImageFileError {
            throw error
        } catch let error as CocoaError where error.code == .fileReadNoSuchFile {
            throw ImageFileError(url, code: .noSuchFile, underlyingError: error)
        } catch {
            throw ImageFileError(url, code: .unknown, underlyingError: error)
        }
    }
    
    /// The file sURL.
    public let url: URL
    
    /// The total file size, in bytes.
    public let fileSize: Int?
    
    /// The formatted file size.
    public var formattedFileSize: String? {
        fileSize?.formatted(
            .byteCount(
                style: .memory,
                spellsOutZero: true,
                includesActualByteCount: true
            )
        )
    }
        
    /// The name of the image file.
    public var filename: String { url.lastPathComponent }
    
    /// The basename of the image file.
    public var basename: String { url.deletingPathExtension().lastPathComponent }
    
    /// The file path of the image file.
    public var path: String { url.path }
    
    /// The type identifier of the image file.
    public var contentType: String? {
        utType?.identifier
    }
    
    /// The `UTType` of the image file.
    public private(set) var utType: UTType?
}

extension ImageFile: CustomStringConvertible {
    public var description: String {
        url.absoluteString
    }
}

extension ImageFile: Encodable {
    enum CodingKeys: String, CodingKey {
        case basename
        case contentType
        case filename
        case fileSize
        case path
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(basename, forKey: .basename)
        try container.encodeIfPresent(contentType, forKey: .contentType)
        try container.encode(filename, forKey: .filename)
        try container.encodeIfPresent(formattedFileSize, forKey: .fileSize)
        try container.encode(path, forKey: .path)
    }
}
