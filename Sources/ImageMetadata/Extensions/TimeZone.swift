import Foundation

extension TimeZone {
    /// The difference in seconds between this and the provided time zone.
    /// - Parameters:
    ///   - other: The other time zone to use for the calculation.
    ///   - date: The date to use for the calculation. The default value is the current date.
    /// - Returns: A `TimeInterval` representation of the difference in seconds.
    func timeIntervalFromTimeZone(_ other: TimeZone, forDate date: Date = Date()) -> TimeInterval {
        let seconds: Int = secondsFromTimeZone(other, forDate: date)
        return TimeInterval(seconds)
    }
    
    
    /// The difference in seconds between this and the provided time zone.
    /// - Parameters:
    ///   - other: The other time zone to use for the calculation.
    ///   - date: The date to use for the calculation. The default value is the current date.
    /// - Returns: An integer representation of the difference in seconds.
    func secondsFromTimeZone(_ other: TimeZone, forDate date: Date = Date()) -> Int {
        self.secondsFromGMT(for: date) - other.secondsFromGMT(for: date)
    }
}
