import Testing
import Foundation
@testable import ImageMetadata

struct ImageFileTests {

    @Test("Invalid file URL") func initWithInvalidURL() throws {
        let url = try #require(URL(string: "https://example.com"))
        
        #expect(throws: ImageFileError(url, code: .invalidURL)) {
            _ = try ImageFile(url: url)
        }
    }
    
    @Test("Missing file URL") func initWithMissingFileURL() throws {
        let url = URL.init(filePath: "./mia.jpg")
        
        #expect(throws: ImageFileError(url, code: .noSuchFile)) {
            _ = try ImageFile(url: url)
        }
    }
    
    @Test("Invalid image file") func invalidImageFile() throws {
        let url = try #require(Bundle.module.url(forResource: "not-an-image", withExtension: "txt"))
        
        #expect(throws: ImageFileError(url, code: .invalidContentType)) {
            _ = try ImageFile(url: url)
        }
    }
    
    @Test func initWithURL() throws {
        let url = try #require(Bundle.module.url(forResource: "hang-in", withExtension: "jpg"))
        let imageFile = try ImageFile(url: url)
        
        #expect(imageFile.url == url)
        #expect(imageFile.filename == "hang-in.jpg")
        #expect(imageFile.basename == "hang-in")
        #expect(imageFile.contentType == "public.jpeg")
        #expect(imageFile.fileSize == 366533)
        
    }
    
    @Test func initWithPath() throws {
        let url = try #require(Bundle.module.url(forResource: "hang-in", withExtension: "jpg"))
        let imageFile = try ImageFile(path: url.path)
        
        #expect(imageFile.url == url)
        #expect(imageFile.filename == "hang-in.jpg")
        #expect(imageFile.basename == "hang-in")
        #expect(imageFile.contentType == "public.jpeg")
        #expect(imageFile.fileSize == 366533)
    }
}
