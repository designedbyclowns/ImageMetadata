import Testing
import Foundation
import Numerics
@testable import ImageMetadata

struct IPTCTests {
    let iptc: IPTC
    
    init() throws {
        let url = try #require(Bundle.module.url(forResource: "iptc", withExtension: "jpg"))
        let imageFile = try ImageFile(url: url)
        let image = try ImageMetadata(imageFile: imageFile)
        self.iptc = try #require(image.iptc)
    }
    
    //    @Test func apertureValue() throws {
    //        let apertureValue = try #require(exif.apertureValue)
    //        #expect(apertureValue.isApproximatelyEqual(to: 1.35614, absoluteTolerance: 0.00001))
    //    }
    
    @Test func urgency() throws {
        #expect(iptc.urgency == nil)
    }
    
    @Test func subjectReference() throws {
        #expect(iptc.subjectReference == nil)
    }
    
    @Test func category() throws {
        #expect(iptc.category == nil)
    }
    
    @Test func supplementalCategory() throws {
        #expect(iptc.supplementalCategory == nil)
    }
    
    @Test func fixtureIdentifier() throws {
        #expect(iptc.fixtureIdentifier == nil)
    }
    
    @Test func keywords() throws {
        #expect(iptc.keywords == ["Keyword1ref2023.2", "Keyword2ref2023.2", "Keyword3ref2023.2"])
    }
    
    @Test func contentLocationCode() throws {
        #expect(iptc.contentLocationCode == nil)
    }
    
    @Test func editStatus() throws {
        #expect(iptc.editStatus == nil)
    }
    
    @Test func editorialUpdate() throws {
        #expect(iptc.editorialUpdate == nil)
    }
    
    @Test func objectCycle() throws {
        #expect(iptc.objectCycle == nil)
    }
    
    @Test func imageType() throws {
        #expect(iptc.imageType == nil)
    }
    
    @Test func imageOrientation() throws {
        #expect(iptc.imageOrientation == nil)
    }
    
    @Test func languageIdentifier() throws {
        #expect(iptc.languageIdentifier == nil)
    }
    
    @Test func captionAbstract() throws {
        #expect(iptc.captionAbstract ==  "The description aka caption (ref2023.2)")
    }
    
    @Test func headline() throws {
        #expect(iptc.headline == "The Headline (ref2023.2)")
    }
    
    @Test func creditLine() throws {
        #expect(iptc.creditLine == "Credit Line (ref2023.2)")
    }
    
    @Test func starRating() throws {
        #expect(iptc.starRating == nil)
    }
    
    @Test func sceneCodes() throws {
        #expect(iptc.sceneCodes == nil)
    }
    
    @Test func copyrightNotice() throws {
        #expect(iptc.copyrightNotice == "Copyright (Notice) 2023.2 IPTC - www.iptc.org  (ref2023.2)")
    }
    
    @Test func rightsUsageTerms() throws {
        #expect(iptc.rightsUsageTerms == "Rights Usage Terms (ref2023.2)")
    }
    
    @Test func releaseDate() throws {
        #expect(iptc.releaseDate == nil)
    }
    
    @Test func expirationDate() throws {
        #expect(iptc.releaseDate == nil)
    }
    
    @Test func specialInstructions() throws {
        #expect(iptc.specialInstructions == "An Instruction (ref2023.2)")
    }
    
    @Test func actionAdvised() throws {
        #expect(iptc.actionAdvised == nil)
    }
    
    @Test func referenceService() throws {
        #expect(iptc.referenceService == nil)
    }
    
    @Test func referenceDate() throws {
        #expect(iptc.referenceDate == nil)
    }
    
    @Test func referenceNumber() throws {
        #expect(iptc.referenceNumber == nil)
    }
    
    @Test func creationDate() throws {
        #expect(iptc.creationDate == nil)
    }
    
    @Test func digitalCreationDate() throws {
        #expect(iptc.digitalCreationDate == nil)
    }
    
    @Test func byline() throws {
        #expect(iptc.byline == ["Creator1 (ref2023.2)"])
    }
    
    @Test func bylineTitle() throws {
        #expect(iptc.bylineTitle == nil)
    }
    
    @Test func source() throws {
        #expect(iptc.source == "Source (ref2023.2)")
    }
    
    @Test func contact() throws {
        #expect(iptc.contact == nil)
    }
    
    @Test func writerEditor() throws {
        #expect(iptc.writerEditor == nil)
    }
    
    @Test func creatorContactInfo() throws {
        #expect(iptc.creatorContactInfo == nil)
    }
    
    @Test func city() throws {
        #expect(iptc.city ==  "City (Core) (ref2023.2)")
    }
    
    @Test func subLocation() throws {
        #expect(iptc.subLocation == "Sublocation (Core) (ref2023.2)")
    }
    
    @Test func provinceState() throws {
        #expect(iptc.provinceState == "Province/State(Core)(ref2023.2)")
    }
    
    @Test func countryCode() throws {
        #expect(iptc.countryCode == "R23")
    }
    
    @Test func country() throws {
        #expect(iptc.country == "Country (Core) (ref2023.2)")
    }
    
    @Test func originalTransmissionReference() throws {
        #expect(iptc.originalTransmissionReference == "Job Id (ref2023.2)")
    }
    
    @Test func originatingProgram() throws {
        #expect(iptc.originatingProgram == nil)
    }
    
    @Test func programVersion() throws {
        #expect(iptc.programVersion == nil)
    }
    
    @Test func objectType() throws {
        #expect(iptc.objectType == nil)
    }
    
    @Test func objectAttribute() throws {
        #expect(iptc.objectAttribute == nil)
    }
    
    @Test func objectName() throws {
        #expect(iptc.objectName == "The Title (ref2023.2)")
    }
}
