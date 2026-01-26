import Testing
import Foundation
@testable import Shared
@testable import imgmd
@testable import ImageMetadata

struct imgmdTests {

    func perform(options: [String]) async throws -> [String: Any] {
        let url = try #require(Shared.url(forResource: "WindowAtLeGras", withExtension: "jpg"))
        let fileArg = url.standardizedFileURL.relativePath
        let args = options + [fileArg]
        
        let output = try run(args: args)
        
        guard let json = try JSONSerialization.jsonObject(with: Data(output.utf8), options: []) as? [String: Any], JSONSerialization.isValidJSONObject(json) else {
            throw "Invalid JSON"
        }
        
        return json
    }
    
    @Test func noOptions() async throws {
        let json = try await perform(options: [])
        
        #expect(json["exif"] != nil)
        #expect(json["iptc"] != nil)
        #expect(json["tiff"] != nil)
        #expect(json["gps"] != nil)
    }
    
    @Test func basicOption() async throws {
        let json = try await perform(options: ["--basic"])
        
        #expect(json["exif"] == nil)
        #expect(json["iptc"] == nil)
        #expect(json["tiff"] == nil)
        #expect(json["gps"] == nil)
        
        let contentType = try #require(json["contentType"] as? String)
        #expect(contentType == "public.jpeg")
        
        let pixelHeight = try #require(json["pixelHeight"] as? Int)
        #expect(pixelHeight == 3810)
        
        let pixelWidth = try #require(json["pixelWidth"] as? Int)
        #expect(pixelWidth == 4530)
                
        let filename = try #require(json["filename"] as? String)
        #expect(filename == "WindowAtLeGras.jpg")
        
        let fileSize = try #require(json["fileSize"] as? String)
        #expect(fileSize == "2.1 MB (2,240,988 bytes)")
    }
    
    @Test func exifOption() async throws {
        let json = try await perform(options: ["--exif"])

        #expect(json["iptc"] == nil)
        #expect(json["tiff"] == nil)
        #expect(json["gps"] == nil)
        
        let exif = try #require(json["exif"] as? [String: Any])
        #expect(JSONSerialization.isValidJSONObject(exif) == true)
        
        let dateTimeOriginal = try #require(exif["dateTimeOriginal"] as? String)
        
        #expect(dateTimeOriginal == "1826-06-01T12:00:00.199+0200")
        
        let offsetTimeOriginal = try #require(exif["offsetTimeOriginal"] as? String)
        #expect(offsetTimeOriginal == "+02:00")
    }
    
    @Test func iptcOption() async throws {
        let json = try await perform(options: ["--iptc"])
        
        #expect(json["exif"] == nil)
        #expect(json["tiff"] == nil)
        #expect(json["gps"] == nil)
        
        let iptc = try #require(json["iptc"] as? [String: Any])
        #expect(JSONSerialization.isValidJSONObject(iptc) == true)
        
        let byline = try #require(iptc["byline"] as? [String])
        #expect(byline.first == "Joseph Nicéphore Niépce")
        
        let captionAbstract = try #require(iptc["captionAbstract"] as? String)
        #expect(captionAbstract == "The earliest surviving camera photograph.")
        
        let city = try #require(iptc["city"] as? String)
        #expect(city == "Saint-Loup-de-Varennes")
        
        let copyrightNotice = try #require(iptc["copyrightNotice"] as? String)
        #expect(copyrightNotice == "Public Domain")
        
        let country = try #require(iptc["country"] as? String)
        #expect(country == "France")
        
        let headline = try #require(iptc["headline"] as? String)
        #expect(headline == "View from the Window at Le Gras")
    }
    
    @Test func tiffOption() async throws {
        let json = try await perform(options: ["--tiff"])
        
        #expect(json["exif"] == nil)
        #expect(json["iptc"] == nil)
        #expect(json["gps"] == nil)
        
        let tiff = try #require(json["tiff"] as? [String: Any])
        #expect(JSONSerialization.isValidJSONObject(tiff) == true)
        
        let artist = try #require(tiff["artist"] as? String)
        #expect(artist == "Joseph Nicéphore Niépce")
        
        let copyright = try #require(tiff["copyright"] as? String)
        #expect(copyright == "Public Domain")
        
        let imageDescription = try #require(tiff["imageDescription"] as? String)
        #expect(imageDescription == "The earliest surviving camera photograph.")
    }
    
    @Test func gpsOption() async throws {
        let json = try await perform(options: ["--gps"])
        
        #expect(json["exif"] == nil)
        #expect(json["iptc"] == nil)
        #expect(json["tiff"] == nil)
        
        let gps = try #require(json["gps"] as? [String: Any])
        #expect(JSONSerialization.isValidJSONObject(gps) == true)
        
        let latitude = try #require(gps["latitude"] as? Double)
        #expect(latitude == 46.72519666666667)
        
        let longitude = try #require(gps["longitude"] as? Double)
        #expect(longitude == -4.860291666666667)
        
        let latitudeReference = try #require(gps["latitudeReference"] as? String)
        #expect(latitudeReference == "N")
        
        let longitudeReference = try #require(gps["longitudeReference"] as? String)
        #expect(longitudeReference == "E")
        
        let dateTime = try #require(gps["dateTime"] as? String)
        #expect(dateTime == "2025-02-13T15:02:45Z")
    }
    
    @Test func unknownOption() async throws {
        let error = await #expect(throws: String.self) {
            _ = try await perform(options: ["--xyz"])
        }
        let errorString = try #require(error)
        #expect(errorString.hasPrefix("Error: Unknown option '--xyz'."))
    }
    
    @Test func executableURLResolution() throws {
        let url = executableURL()
        let exists = FileManager.default.fileExists(atPath: url.path)
        #expect(exists == true)
    }
    
    private func executableURL() -> URL {
        var url = Bundle.module.bundleURL
        
        // This is an ugly hack to support testing both Xcode and Terminal.
        if url.pathComponents.contains("Xcode") {
            url.append(component: "../../../../", directoryHint: .notDirectory)
        } else {
            url.deleteLastPathComponent()
        }
        
        url.append(component: "imgmd", directoryHint: .notDirectory)
        url.standardize()
        return url
    }
    
    private func run(args: [String]) throws -> String {
        let executableURL = executableURL()
        
        let process = Process()
        process.executableURL = executableURL
        process.arguments = args

        let stdout = Pipe()
        process.standardOutput = stdout

        let stderr = Pipe()
        process.standardError = stderr

        try process.run()
        process.waitUntilExit()

        let errorData = stderr.fileHandleForReading.readDataToEndOfFile()
        guard errorData.isEmpty else {
            throw String(data: errorData, encoding: .utf8) ?? "Unknown error"
        }
        
        let outputData = stdout.fileHandleForReading.readDataToEndOfFile()
        
        guard let output = String(data: outputData, encoding: .utf8) else {
            throw("Invalid output")
        }

        return output
    }
}

extension String: @retroactive Error {}
