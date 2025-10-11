import Foundation

public protocol Metadata: Encodable & CustomStringConvertible & Sendable {}

extension Metadata {
    
    // MARK:  CustomStringConvertible
    
    public var description: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        encoder.dateEncodingStrategy = .iso8601
        
        guard let json = try? encoder.encode(self) else { return "" }
        return String(decoding: json, as: UTF8.self)
    }
}
