import Foundation
import ArgumentParser
import ImageMetadata

enum MetadataType: String, EnumerableFlag {
    case exif, iptc, tiff, gps
}

extension MetadataType {
    var metadataOption: MetadataOptions {
        switch self {
        case .exif:
            return .exif
        case .iptc:
            return .iptc
        case .tiff:
            return .tiff
        case .gps:
            return .gps
        }
    }
}


@main
struct imgmd: ParsableCommand {
    
    static let configuration = CommandConfiguration(
        abstract: "Extract image metadata.",
        discussion: """
        Outputs metadata from the supplied image files as JSON.
        """
    )
    
    @Flag(name: .shortAndLong, help: "Basic. Don't include other metadata.")
    var basic: Bool = false
    
    @Flag(name: .shortAndLong, inversion: .prefixedNo, help: "Include EXIF metadata.")
    var exif: Bool = true
    
    @Flag(name: .shortAndLong, inversion: .prefixedNo, help: "Include GPS metadata.")
    var gps: Bool = true
    
    @Flag(name: .shortAndLong, inversion: .prefixedNo, help: "Include IPTC metadata.")
    var iptc: Bool = true
    
    @Flag(name: .shortAndLong, inversion: .prefixedNo, help: "Include TIFF metadata.")
    var tiff: Bool = true
    
    @Flag(name: .shortAndLong, help: "Show the raw metadata.")
    var debug: Bool = false
    
    @Argument(
        help: "Image files.",
        completion: .file(),
        transform: {
            URL.init(fileURLWithPath: $0)
        }
    )
    var files: [URL] = []
    
    mutating func run() throws {
        guard files.count >= 1 else {
            throw ValidationError("Please specify at least one image file.")
        }
        
        var metadataOptions = MetadataOptions()
        if basic {
            metadataOptions = MetadataOptions.none
        } else {
            if exif { metadataOptions.insert(.exif) }
            if iptc { metadataOptions.insert(.iptc) }
            if tiff { metadataOptions.insert(.tiff) }
            if gps { metadataOptions.insert(.gps) }
        }
                    
        let imagesMetadata = try files.map {
            return try ImageMetadata(url: $0, options: metadataOptions)
        }
        
        guard !imagesMetadata.isEmpty else { return }
        
        guard debug == false else {
            let rawValues = imagesMetadata.map { $0.rawValue as AnyObject }
            print(rawValues)
            return
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        encoder.dateEncodingStrategy = .iso8601
                
        var json: Data = Data()
        
        if imagesMetadata.count > 1 {
            json = try encoder.encode(imagesMetadata)
        } else if let metadata = imagesMetadata.first {
            json = try encoder.encode(metadata)
        }
        
        print(String(decoding: json, as: UTF8.self))
    }
}
