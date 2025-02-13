import Foundation

protocol Metadata: RawRepresentable & Encodable & CustomStringConvertible & CustomDebugStringConvertible {}

extension Metadata {
    
    // MARK:  CustomStringConvertible
    
    public var description: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        encoder.dateEncodingStrategy = .iso8601
        
        guard let json = try? encoder.encode(self) else { return "" }
        return String(decoding: json, as: UTF8.self)
    }
    
    // MARK: CustomDebugStringConvertible
    
    public var debugDescription: String {
        String(describing: rawValue)
    }
}
