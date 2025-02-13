import Foundation
import ImageIO

extension EXIF {
    /// The kind of light source.
    public enum LightSource: Int, Codable {
        /// Unknown
        case unknown = 0
        /// Daylight
        case daylight = 1
        /// Fluorescent
        case fluorescent = 2
        /// Tungsten
        ///
        /// Incandescent light.
        case tungsten = 3
        /// Flash
        case flash = 4
        /// Fine weather
        case fineWeather = 9
        /// Cloudy weather
        case cloudyWeather = 10
        /// Shade
        case shade = 11
        /// Daylight fluorescent
        ///
        /// D 5700 – 7100K.
        case daylightFluorescent = 12
        /// Day white fluorescent
        ///
        /// N 4600 – 5400K.
        case dayWhiteFluorescent = 13
        /// Cool white fluorescent
        ///
        /// W 3900 – 4500K.
        case coolWhiteFluorescent = 14
        /// White fluorescent
        ///
        /// WW 3200 – 3700K.
        case whiteFluorescent = 15
        /// Standard light A
        case standardLightA = 17
        /// Standard light B
        case standardLightB = 18
        /// Standard light C
        case standardLightC = 19
        /// D55
        case d55 = 20
        /// D65
        case d65 = 21
        /// D75
        case d75 = 22
        /// D50
        case d50 = 23
        /// ISO studio tungsten
        case isoStudioTungsten = 24
        /// Other light source
        case other = 255
    }
}

extension EXIF.LightSource: CustomStringConvertible {
    public var description: String {
        switch self {
        case .cloudyWeather:
            String(localized: "Cloudy weather")
        case .unknown:
            String(localized: "Unknown")
        case .daylight:
            String(localized: "Daylight")
        case .fluorescent:
            String(localized: "Fluorescent")
        case .tungsten:
            String(localized: "Tungsten (incandescent light)")
        case .flash:
            String(localized: "Flash")
        case .fineWeather:
            String(localized: "Fine weather")
        case .shade:
            String(localized: "Shade")
        case .daylightFluorescent:
            String(localized: "Daylight fluorescent (D 5700 – 7100K)")
        case .dayWhiteFluorescent:
            String(localized: "Day white fluorescent (N 4600 – 5400K)")
        case .coolWhiteFluorescent:
            String(localized: "Cool white fluorescent (W 3900 – 4500K)")
        case .whiteFluorescent:
            String(localized: "White fluorescent (WW 3200 – 3700K)")
        case .standardLightA:
            String(localized: "Standard light A")
        case .standardLightB:
            String(localized: "Standard light B")
        case .standardLightC:
            String(localized: "Standard light C")
        case .d55:
            String(localized: "D55")
        case .d65:
            String(localized: "D65")
        case .d75:
            String(localized: "D70")
        case .d50:
            String(localized: "D50")
        case .isoStudioTungsten:
            String(localized: "ISO studio tungsten")
        case .other:
            String(localized: "Other light source")
        }
    }
}
