import Testing
import Foundation
@testable import ImageMetadata

struct ImageMetadataTests {
    
    let imageFile: ImageFile
    
    init() throws {
        let url = try #require(Bundle.module.url(forResource: "metadata-test", withExtension: "jpg"))
        imageFile = try ImageFile(url: url)
    }
    
    @Test func initWithURL() throws {
        let metadata = try ImageMetadata(imageFile: imageFile)
        
        #expect(metadata.imageFile?.filename == "metadata-test.jpg")
        #expect(metadata.imageFile?.basename == "metadata-test")
        #expect(metadata.imageFile?.contentType == "public.jpeg")
        #expect(metadata.imageFile?.fileSize == 22330)
        
        #expect(metadata.contentType?.identifier == "public.jpeg")
        
        #expect(metadata.bitDepth == 8)
        #expect(metadata.pixelFormat == nil)
        #expect(metadata.pixelHeight == 67)
        #expect(metadata.pixelWidth == 100)
        #expect(metadata.dpiHeight == 72)
        #expect(metadata.dpiWidth == 72)
        
        #expect(metadata.orientation == .up)
        #expect(metadata.isFloat == false)
        #expect(metadata.isIndexed == false)
        #expect(metadata.hasAlpha == false)
        #expect(metadata.colorModel == "RGB")
        
        #expect(metadata.exif != nil)
        #expect(metadata.iptc != nil)
        #expect(metadata.tiff != nil)
        #expect(metadata.gps != nil)
    }
}
