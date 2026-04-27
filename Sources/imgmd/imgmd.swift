import Foundation
import ArgumentParser
import ImageMetadata
import UniformTypeIdentifiers

fileprivate enum MetadataType: String, EnumerableFlag {
    case exif, iptc, tiff, gps, dng, png, gif, eightBIM, heic, jfif, webP
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
        case .dng:
            return .dng
        case .png:
            return .png
        case .gif:
            return .gif
        case .eightBIM:
            return .eightBIM
        case .heic:
            return .heic
        case .jfif:
            return .jfif
        case .webP:
            return .webP
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

    @Flag(name: .long, inversion: .prefixedNo, help: "Include DNG metadata.")
    var dng: Bool = false

    @Flag(name: .shortAndLong, inversion: .prefixedNo, help: "Include PNG metadata.")
    var png: Bool = false

    @Flag(name: .long, inversion: .prefixedNo, help: "Include GIF metadata.")
    var gif: Bool = false

    @Flag(name: [.customLong("8bim"), .customLong("eight-bim")], inversion: .prefixedNo, help: "Include 8BIM (Photoshop) metadata.")
    var eightBIM: Bool = false

    @Flag(name: .long, inversion: .prefixedNo, help: "Include HEIC metadata.")
    var heic: Bool = false

    @Flag(name: .long, inversion: .prefixedNo, help: "Include JFIF metadata.")
    var jfif: Bool = false

    @Flag(name: .customLong("webp"), inversion: .prefixedNo, help: "Include WebP metadata.")
    var webP: Bool = false

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
        if dng { metadataOptions.insert(.dng) }
        if png { metadataOptions.insert(.png) }
        if gif { metadataOptions.insert(.gif) }
        if eightBIM { metadataOptions.insert(.eightBIM) }
        if heic { metadataOptions.insert(.heic) }
        if jfif { metadataOptions.insert(.jfif) }
        if webP { metadataOptions.insert(.webP) }

        if basic {
            metadataOptions = MetadataOptions.none
        } else if metadataOptions.isEmpty {
            metadataOptions = MetadataOptions.all
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
