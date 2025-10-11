import Foundation
import ArgumentParser
import ImageMetadata

fileprivate enum MetadataType: String, EnumerableFlag {
    case exif, iptc, tiff, gps
}

fileprivate extension MetadataType {
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
        abstract: "Outputs metadata from the supplied image files as JSON.",
        discussion: """
        All metadata is output by default. Use the options to limit what metadata is displayed.
        """
    )
    
    @Flag(name: .shortAndLong, help: "Basic. Don't include other metadata.")
    var basic: Bool = false
    
    @Flag(name: .shortAndLong, inversion: .prefixedNo, help: "Include EXIF metadata.")
    var exif: Bool = false
    
    @Flag(name: .shortAndLong, inversion: .prefixedNo, help: "Include GPS metadata.")
    var gps: Bool = false
    
    @Flag(name: .shortAndLong, inversion: .prefixedNo, help: "Include IPTC metadata.")
    var iptc: Bool = false
    
    @Flag(name: .shortAndLong, inversion: .prefixedNo, help: "Include TIFF metadata.")
    var tiff: Bool = false
    
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
        
        guard debug == false else {
            let rawValues = files.compactMap {
                try? ImageMetadata.getProperties(url: $0) as AnyObject
            }
            print(rawValues)
            return
        }
        
        var metadataOptions = MetadataOptions()
        
        if exif { metadataOptions.insert(.exif) }
        if iptc { metadataOptions.insert(.iptc) }
        if tiff { metadataOptions.insert(.tiff) }
        if gps { metadataOptions.insert(.gps) }
        
        if basic {
            metadataOptions = MetadataOptions.none
        } else if metadataOptions.isEmpty {
            metadataOptions = MetadataOptions.all
        }
        
        let imagesMetadata = try files.map {
            try ImageMetadata(url: $0, options: metadataOptions)
        }
        
        guard !imagesMetadata.isEmpty else { return }
        
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
