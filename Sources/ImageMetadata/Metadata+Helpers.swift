import Foundation

extension Metadata {
    /// Coerce a value from an `NSDictionary` into `[Int]?`, handling both the
    /// already-bridged `[Int]` form and the underlying `[NSNumber]` form that
    /// Core Foundation typically hands back.
    static func intArray(_ value: Any?) -> [Int]? {
        if let arr = value as? [Int] { return arr }
        if let arr = value as? [NSNumber] { return arr.map(\.intValue) }
        return nil
    }

    /// Coerce a value from an `NSDictionary` into `[Double]?`, handling both the
    /// already-bridged `[Double]` form and the underlying `[NSNumber]` form.
    static func doubleArray(_ value: Any?) -> [Double]? {
        if let arr = value as? [Double] { return arr }
        if let arr = value as? [NSNumber] { return arr.map(\.doubleValue) }
        return nil
    }

    /// String description of an arbitrary value, returning `nil` for missing
    /// or `NSNull` entries.
    static func describe(_ value: Any?) -> String? {
        guard let value, !(value is NSNull) else { return nil }
        return String(describing: value)
    }

    /// Join the components of a version-tag array (e.g. `[1, 4, 0, 0]`) into
    /// a dotted string (`"1.4.0.0"`).
    static func versionString(_ value: Any?) -> String? {
        guard let components = value as? [CustomStringConvertible] else { return nil }
        return components.map { String(describing: $0) }.joined(separator: ".")
    }
}
