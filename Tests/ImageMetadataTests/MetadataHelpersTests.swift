import Testing
import Foundation
@testable import ImageMetadata


/// Minimal `Metadata` conformer used to invoke the static helpers under test.
private struct TestMetadata: Metadata {}


struct MetadataHelpersTests {

    // MARK: - intArray

    @Test("intArray returns nil for nil input")
    func intArrayNil() {
        #expect(TestMetadata.intArray(nil) == nil)
    }

    @Test("intArray returns nil for NSNull")
    func intArrayNSNull() {
        #expect(TestMetadata.intArray(NSNull()) == nil)
    }

    @Test("intArray passes through a native [Int]")
    func intArrayNativeInt() {
        #expect(TestMetadata.intArray([1, 2, 3]) == [1, 2, 3])
    }

    @Test("intArray bridges [NSNumber]")
    func intArrayNSNumberBridge() {
        let nsNumbers: [NSNumber] = [NSNumber(value: 7), NSNumber(value: 11), NSNumber(value: 13)]
        #expect(TestMetadata.intArray(nsNumbers) == [7, 11, 13])
    }

    @Test("intArray truncates [NSNumber] containing doubles")
    func intArrayNSNumberDoubleTruncates() {
        let nsNumbers: [NSNumber] = [NSNumber(value: 1.7), NSNumber(value: 2.9)]
        #expect(TestMetadata.intArray(nsNumbers) == [1, 2])
    }

    @Test("intArray returns empty for empty array")
    func intArrayEmpty() {
        #expect(TestMetadata.intArray([] as [Int]) == [])
        #expect(TestMetadata.intArray([] as [NSNumber]) == [])
    }

    @Test("intArray returns nil for non-array input")
    func intArrayWrongType() {
        #expect(TestMetadata.intArray("not an array") == nil)
        #expect(TestMetadata.intArray(42) == nil)
    }

    @Test("intArray returns nil for [String]")
    func intArrayWrongElementType() {
        #expect(TestMetadata.intArray(["1", "2"]) == nil)
    }

    // MARK: - doubleArray

    @Test("doubleArray returns nil for nil input")
    func doubleArrayNil() {
        #expect(TestMetadata.doubleArray(nil) == nil)
    }

    @Test("doubleArray returns nil for NSNull")
    func doubleArrayNSNull() {
        #expect(TestMetadata.doubleArray(NSNull()) == nil)
    }

    @Test("doubleArray passes through a native [Double]")
    func doubleArrayNativeDouble() {
        #expect(TestMetadata.doubleArray([1.5, 2.5, 3.5]) == [1.5, 2.5, 3.5])
    }

    @Test("doubleArray bridges [NSNumber] with double values")
    func doubleArrayNSNumberDoubleBridge() {
        let nsNumbers: [NSNumber] = [NSNumber(value: 0.5), NSNumber(value: 1.25)]
        #expect(TestMetadata.doubleArray(nsNumbers) == [0.5, 1.25])
    }

    @Test("doubleArray bridges [NSNumber] with integer values")
    func doubleArrayNSNumberIntBridge() {
        let nsNumbers: [NSNumber] = [NSNumber(value: 1), NSNumber(value: 2)]
        #expect(TestMetadata.doubleArray(nsNumbers) == [1.0, 2.0])
    }

    @Test("doubleArray returns empty for empty array")
    func doubleArrayEmpty() {
        #expect(TestMetadata.doubleArray([] as [Double]) == [])
        #expect(TestMetadata.doubleArray([] as [NSNumber]) == [])
    }

    @Test("doubleArray returns nil for non-array input")
    func doubleArrayWrongType() {
        #expect(TestMetadata.doubleArray("not an array") == nil)
        #expect(TestMetadata.doubleArray(3.14) == nil)
    }

    // MARK: - describe

    @Test("describe returns nil for nil input")
    func describeNil() {
        #expect(TestMetadata.describe(nil) == nil)
    }

    @Test("describe returns nil for NSNull")
    func describeNSNull() {
        #expect(TestMetadata.describe(NSNull()) == nil)
    }

    @Test("describe stringifies common scalar values")
    func describeScalars() {
        #expect(TestMetadata.describe("hello") == "hello")
        #expect(TestMetadata.describe(42) == "42")
        #expect(TestMetadata.describe(3.5) == "3.5")
        #expect(TestMetadata.describe(true) == "true")
    }

    @Test("describe stringifies a dictionary")
    func describeDictionary() throws {
        let value: [String: Double] = ["k0": 1.0, "k1": 2.0]
        let result = try #require(TestMetadata.describe(value))
        // Dictionary order isn't guaranteed; just verify the keys are present.
        #expect(result.contains("k0"))
        #expect(result.contains("k1"))
    }
}
