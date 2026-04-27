import Foundation
import ArgumentParser
import ImageMetadata
import UniformTypeIdentifiers

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
        }

        let imagesMetadata = try files.map { url -> ImageMetadata in
            var options = metadataOptions
            if !basic {
                if Self.conforms(url: url, to: .dng) {
                    options.insert(.dng)
                }
                if Self.conforms(url: url, to: .png) {
                    options.insert(.png)
                }
                if Self.conforms(url: url, to: .gif) {
                    options.insert(.gif)
                }
                // 8BIM blocks live in PSD, but Photoshop also embeds them in
                // JPEGs and TIFFs it has touched.
                if Self.conforms(url: url, to: .jpeg) || Self.conforms(url: url, to: .tiff) {
                    options.insert(.eightBIM)
                }
                if let psd = UTType("com.adobe.photoshop-image"), Self.conforms(url: url, to: psd) {
                    options.insert(.eightBIM)
                }
                if Self.conforms(url: url, to: .heic) || Self.conforms(url: url, to: .heics) {
                    options.insert(.heic)
                }
                if Self.conforms(url: url, to: .jpeg) {
                    options.insert(.jfif)
                }
                if Self.conforms(url: url, to: .webP) {
                    options.insert(.webP)
                }
            }
            return try ImageMetadata(url: url, options: options)
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

    private static func conforms(url: URL, to target: UTType) -> Bool {
        guard let values = try? url.resourceValues(forKeys: [.contentTypeKey]),
              let type = values.contentType else {
            return false
        }
        return type.conforms(to: target)
    }
}
