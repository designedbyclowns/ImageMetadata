import Testing
import Foundation
@testable import ImageMetadata

@Suite("Calendar Extension Tests")
struct CalendarTests {

    let referenceDate: Date

    init() throws {
        // Fixed reference instant: 2026-02-13 12:00:00 UTC.
        var utcCalendar = Calendar.gregorian
        utcCalendar.timeZone = try #require(TimeZone(identifier: "UTC"))
        referenceDate = try #require(
            DateComponents(
                calendar: utcCalendar,
                timeZone: TimeZone(identifier: "UTC"),
                year: 2026, month: 2, day: 13,
                hour: 12, minute: 0, second: 0
            ).date
        )
    }

    // MARK: - Gregorian Calendar Tests

    @Test("Gregorian calendar has correct identifier")
    func gregorianCalendarIdentifier() {
        #expect(Calendar.gregorian.identifier == .gregorian)
    }

    // MARK: - Time Zone Setting Tests
    //
    // `Calendar.date(bySettingTimeZone:of:)` shifts the underlying instant so
    // that when viewed in the destination time zone, the wall-clock components
    // match those of the original date when viewed in the source zone.

    @Test("Setting EST on a UTC date preserves wall-clock components in EST")
    func convertUTCToEST() throws {
        var calendar = Calendar.gregorian
        calendar.timeZone = try #require(TimeZone(identifier: "UTC"))

        let est = try #require(TimeZone(identifier: "America/New_York"))
        let converted = try #require(calendar.date(bySettingTimeZone: est, of: referenceDate))

        var estCalendar = Calendar.gregorian
        estCalendar.timeZone = est
        let components = estCalendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: converted
        )

        #expect(components.year == 2026)
        #expect(components.month == 2)
        #expect(components.day == 13)
        #expect(components.hour == 12)
        #expect(components.minute == 0)
    }

    @Test("Setting JST on a PST date preserves wall-clock components in JST")
    func convertPSTToJST() throws {
        var calendar = Calendar.gregorian
        let pst = try #require(TimeZone(identifier: "America/Los_Angeles"))
        calendar.timeZone = pst

        let pstDate = try #require(
            DateComponents(
                calendar: calendar,
                timeZone: pst,
                year: 2026, month: 2, day: 13,
                hour: 9, minute: 30, second: 0
            ).date
        )

        let jst = try #require(TimeZone(identifier: "Asia/Tokyo"))
        let converted = try #require(calendar.date(bySettingTimeZone: jst, of: pstDate))

        var jstCalendar = Calendar.gregorian
        jstCalendar.timeZone = jst
        let components = jstCalendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: converted
        )

        #expect(components.year == 2026)
        #expect(components.month == 2)
        #expect(components.day == 13)
        #expect(components.hour == 9)
        #expect(components.minute == 30)
    }

    @Test("Setting the same time zone returns the same instant")
    func convertToSameTimeZone() throws {
        var calendar = Calendar.gregorian
        let utc = try #require(TimeZone(identifier: "UTC"))
        calendar.timeZone = utc

        let converted = try #require(calendar.date(bySettingTimeZone: utc, of: referenceDate))

        #expect(abs(converted.timeIntervalSince(referenceDate)) < 1.0)
    }

    @Test("Setting Sydney on a late-evening UTC date preserves the day in Sydney")
    func convertAcrossDateBoundaryForward() throws {
        var calendar = Calendar.gregorian
        calendar.timeZone = try #require(TimeZone(identifier: "UTC"))

        let lateUtc = try #require(
            DateComponents(
                calendar: calendar,
                timeZone: TimeZone(identifier: "UTC"),
                year: 2026, month: 2, day: 13,
                hour: 23, minute: 0, second: 0
            ).date
        )

        let sydney = try #require(TimeZone(identifier: "Australia/Sydney"))
        let converted = try #require(calendar.date(bySettingTimeZone: sydney, of: lateUtc))

        var sydneyCalendar = Calendar.gregorian
        sydneyCalendar.timeZone = sydney
        let components = sydneyCalendar.dateComponents(
            [.year, .month, .day, .hour],
            from: converted
        )

        #expect(components.year == 2026)
        #expect(components.month == 2)
        #expect(components.day == 13)
        #expect(components.hour == 23)
    }

    @Test("Setting Hawaii on an early-morning UTC date preserves the day in Hawaii")
    func convertAcrossDateBoundaryBackward() throws {
        var calendar = Calendar.gregorian
        calendar.timeZone = try #require(TimeZone(identifier: "UTC"))

        let earlyUtc = try #require(
            DateComponents(
                calendar: calendar,
                timeZone: TimeZone(identifier: "UTC"),
                year: 2026, month: 2, day: 13,
                hour: 2, minute: 0, second: 0
            ).date
        )

        let hawaii = try #require(TimeZone(identifier: "Pacific/Honolulu"))
        let converted = try #require(calendar.date(bySettingTimeZone: hawaii, of: earlyUtc))

        var hawaiiCalendar = Calendar.gregorian
        hawaiiCalendar.timeZone = hawaii
        let components = hawaiiCalendar.dateComponents(
            [.year, .month, .day, .hour],
            from: converted
        )

        #expect(components.year == 2026)
        #expect(components.month == 2)
        #expect(components.day == 13)
        #expect(components.hour == 2)
    }

    @Test("Fractional seconds are preserved across time-zone setting")
    func convertDateWithFractionalSeconds() throws {
        var calendar = Calendar.gregorian
        calendar.timeZone = try #require(TimeZone(identifier: "UTC"))

        let utcDate = try #require(
            DateComponents(
                calendar: calendar,
                timeZone: TimeZone(identifier: "UTC"),
                year: 2026, month: 2, day: 13,
                hour: 12, minute: 30, second: 45,
                nanosecond: 500_000_000
            ).date
        )

        let gmtPlusOne = try #require(TimeZone(secondsFromGMT: 3600))
        let converted = try #require(calendar.date(bySettingTimeZone: gmtPlusOne, of: utcDate))

        var convertedCalendar = Calendar.gregorian
        convertedCalendar.timeZone = gmtPlusOne
        let components = convertedCalendar.dateComponents([.nanosecond], from: converted)
        let nanosecond = try #require(components.nanosecond)

        #expect(abs(nanosecond - 500_000_000) < 1_000_000)
    }

    @Test("Setting NY on a UTC date in DST uses the EDT offset (-4h)")
    func convertUTCToNYDuringDST() throws {
        var calendar = Calendar.gregorian
        calendar.timeZone = try #require(TimeZone(identifier: "UTC"))

        // March 9, 2026 — past the US DST start (March 8), so NY is on EDT (-4h).
        let utcDate = try #require(
            DateComponents(
                calendar: calendar,
                timeZone: TimeZone(identifier: "UTC"),
                year: 2026, month: 3, day: 9,
                hour: 10, minute: 0, second: 0
            ).date
        )

        let ny = try #require(TimeZone(identifier: "America/New_York"))
        let converted = try #require(calendar.date(bySettingTimeZone: ny, of: utcDate))

        // source(0) - target(-4h) = +4h
        let expected: TimeInterval = 4 * 3600
        #expect(abs(converted.timeIntervalSince(utcDate) - expected) < 1.0)
    }

    @Test("Setting EST on the epoch shifts the instant later by 5h")
    func convertEpochDate() throws {
        var calendar = Calendar.gregorian
        calendar.timeZone = try #require(TimeZone(identifier: "UTC"))

        let epoch = Date(timeIntervalSince1970: 0)
        let est = try #require(TimeZone(identifier: "America/New_York"))
        let converted = try #require(calendar.date(bySettingTimeZone: est, of: epoch))

        // EST has been UTC-5 since long before 1970; source(0) - target(-5h) = +5h.
        let expected: TimeInterval = 5 * 3600
        #expect(abs(converted.timeIntervalSince(epoch) - expected) < 1.0)
    }

    @Test("Historical dates preserve wall-clock components across zone setting")
    func convertVeryOldDate() throws {
        var calendar = Calendar.gregorian
        calendar.timeZone = try #require(TimeZone(identifier: "UTC"))

        let oldDate = try #require(
            DateComponents(
                calendar: calendar,
                timeZone: TimeZone(identifier: "UTC"),
                year: 1826, month: 6, day: 1,
                hour: 12, minute: 0, second: 0
            ).date
        )

        let paris = try #require(TimeZone(identifier: "Europe/Paris"))
        let converted = try #require(calendar.date(bySettingTimeZone: paris, of: oldDate))

        var parisCalendar = Calendar.gregorian
        parisCalendar.timeZone = paris
        let components = parisCalendar.dateComponents([.year, .month, .day, .hour], from: converted)

        #expect(components.year == 1826)
        #expect(components.month == 6)
        #expect(components.day == 1)
        #expect(components.hour == 12)
    }

    @Test("Future dates preserve wall-clock components across zone setting")
    func convertFutureDate() throws {
        var calendar = Calendar.gregorian
        calendar.timeZone = try #require(TimeZone(identifier: "UTC"))

        let futureDate = try #require(
            DateComponents(
                calendar: calendar,
                timeZone: TimeZone(identifier: "UTC"),
                year: 2100, month: 12, day: 31,
                hour: 23, minute: 59, second: 59
            ).date
        )

        let sydney = try #require(TimeZone(identifier: "Australia/Sydney"))
        let converted = try #require(calendar.date(bySettingTimeZone: sydney, of: futureDate))

        var sydneyCalendar = Calendar.gregorian
        sydneyCalendar.timeZone = sydney
        let components = sydneyCalendar.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: converted
        )

        #expect(components.year == 2100)
        #expect(components.month == 12)
        #expect(components.day == 31)
        #expect(components.hour == 23)
        #expect(components.minute == 59)
        #expect(components.second == 59)
    }

    @Test("Setting +5:30 on a UTC date shifts the instant earlier by 5.5h")
    func convertWithCustomTimeZoneOffset() throws {
        var calendar = Calendar.gregorian
        calendar.timeZone = try #require(TimeZone(identifier: "UTC"))

        let custom = try #require(TimeZone(secondsFromGMT: 5 * 3600 + 30 * 60))
        let converted = try #require(calendar.date(bySettingTimeZone: custom, of: referenceDate))

        // source(UTC)=0 - target(+5:30)=+19800 => instant shifts by -19800s
        let expected = -5.5 * 3600.0
        #expect(abs(converted.timeIntervalSince(referenceDate) - expected) < 1.0)
    }

    @Test("Setting -6:00 on a UTC date shifts the instant later by 6h")
    func convertWithNegativeTimeZoneOffset() throws {
        var calendar = Calendar.gregorian
        calendar.timeZone = try #require(TimeZone(identifier: "UTC"))

        let custom = try #require(TimeZone(secondsFromGMT: -6 * 3600))
        let converted = try #require(calendar.date(bySettingTimeZone: custom, of: referenceDate))

        // source(UTC)=0 - target(-6h)=-21600 => instant shifts by +21600s
        let expected = 6.0 * 3600.0
        #expect(abs(converted.timeIntervalSince(referenceDate) - expected) < 1.0)
    }

    @Test("UTC -> EST -> PST -> JST -> UTC round-trip is exact")
    func multipleConsecutiveConversions() throws {
        var calendar = Calendar.gregorian
        calendar.timeZone = try #require(TimeZone(identifier: "UTC"))

        let est = try #require(TimeZone(identifier: "America/New_York"))
        let date1 = try #require(calendar.date(bySettingTimeZone: est, of: referenceDate))

        calendar.timeZone = est
        let pst = try #require(TimeZone(identifier: "America/Los_Angeles"))
        let date2 = try #require(calendar.date(bySettingTimeZone: pst, of: date1))

        calendar.timeZone = pst
        let jst = try #require(TimeZone(identifier: "Asia/Tokyo"))
        let date3 = try #require(calendar.date(bySettingTimeZone: jst, of: date2))

        calendar.timeZone = jst
        let utc = try #require(TimeZone(identifier: "UTC"))
        let final = try #require(calendar.date(bySettingTimeZone: utc, of: date3))

        #expect(abs(final.timeIntervalSince(referenceDate)) < 1.0)
    }

    @Test("Calendar locale does not affect time-zone setting")
    func convertWithDifferentLocale() throws {
        var calendar = Calendar.gregorian
        calendar.timeZone = try #require(TimeZone(identifier: "UTC"))
        calendar.locale = Locale(identifier: "ja_JP")

        let jst = try #require(TimeZone(identifier: "Asia/Tokyo"))
        let converted = try #require(calendar.date(bySettingTimeZone: jst, of: referenceDate))

        // source(UTC)=0 - target(+9h)=+32400 => instant shifts by -32400s
        let expected = -9.0 * 3600.0
        #expect(abs(converted.timeIntervalSince(referenceDate) - expected) < 1.0)
    }
}
