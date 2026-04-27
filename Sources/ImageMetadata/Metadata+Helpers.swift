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
}
