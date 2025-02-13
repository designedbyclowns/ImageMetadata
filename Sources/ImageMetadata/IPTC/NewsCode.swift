import Foundation

extension IPTC {
    public enum NewsCode {
        /// Indicates a type of scene covered by an item.
        ///
        /// [Human readable concept data](https://cv.iptc.org/newscodes/scene).
        public enum Scene: String, Codable {
            case headshot = "010100"
            case halfLength = "010200"
            case fullLength = "010300"
            case profile = "010400"
            case rearView = "010500"
            case single = "010600"
            case couple = "010700"
            case two = "010800"
            case group = "010900"
            case generalView = "011000"
            case panoramicView = "011100"
            case aerialView = "011200"
            case underWater = "011300"
            case nightScene = "011400"
            case satellite = "011500"
            case exteriorView = "011600"
            case interiorView = "011700"
            case closeUp = "011800"
            case action = "011900"
            case performing = "012000"
            case posing = "012100"
            case symbolic = "012200"
            case offBeat = "012300"
            case movieScene = "012400"
        }
    }
}

extension IPTC.NewsCode.Scene {
    /// A definition of a ``NewsCode.Scene``.
    public var definition: String {
        switch self {
        case .headshot:
            String(localized: "A head only view of a person (or animal/s) or persons as in a montage.")
        case .halfLength:
            String(localized: "A torso and head view of a person or persons.")
        case .fullLength:
            String(localized: "A view from head to toe of a person or persons.")
        case .profile:
            String(localized: "A view of a person from the side.")
        case .rearView:
            String(localized: "A view of a person or persons from the rear.")
        case .single:
            String(localized: "A view of only one person, object or animal.")
        case .couple:
            String(localized: "A view of two people who are in a personal relationship, for example engaged, married or in a romantic partnership.")
        case .two:
            String(localized: "A view of two people.")
        case .group:
            String(localized: "A view of more than two people.")
        case .generalView:
            String(localized: "An overall view of the subject and its surrounds.")
        case .panoramicView:
            String(localized: "A panoramic or wide angle view of a subject and its surrounds.")
        case .aerialView:
            String(localized: "A view taken from above.")
        case .underWater:
            String(localized: "A photo taken under water.")
        case .nightScene:
            String(localized: "A photo taken during darkness.")
        case .satellite:
            String(localized: "A photo taken from a satellite in orbit.")
        case .exteriorView:
            String(localized: "A photo that shows the exterior of a building or other object.")
        case .interiorView:
            String(localized: "A scene or view of the interior of a building or other object.")
        case .closeUp:
            String(localized: "A view of, or part of a person/object taken at close range in order to emphasize detail or accentuate mood. Macro photography.")
        case .action:
            String(localized: "Subject in motion such as children jumping, horse running.")
        case .performing:
            String(localized: "Subject or subjects on a stage performing to an audience.")
        case .posing:
            String(localized: "Subject or subjects posing such as a 'victory' pose or other stance that symbolizes leadership.")
        case .symbolic:
            String(localized: "A posed picture symbolizing an event - two rings for marriage.")
        case .offBeat:
            String(localized: "An attractive, perhaps fun picture of everyday events - dog with sunglasses, people cooling off in the fountain.")
        case .movieScene:
            String(localized: "Photos taken during the shooting of a movie or TV production.")
        }
    }
}

extension IPTC.NewsCode.Scene: CustomStringConvertible {
    public var description: String {
        switch self {
        case .headshot:
            String(localized: "headshot")
        case .halfLength:
            String(localized: "half-length")
        case .fullLength:
            String(localized: "full-length")
        case .profile:
            String(localized: "profile")
        case .rearView:
            String(localized: "rear view")
        case .single:
            String(localized: "single")
        case .couple:
            String(localized: "couple")
        case .two:
            String(localized: "two")
        case .group:
            String(localized: "group")
        case .generalView:
            String(localized: "general view")
        case .panoramicView:
            String(localized: "panoramic view")
        case .aerialView:
            String(localized: "aerial view")
        case .underWater:
            String(localized: "under-water")
        case .nightScene:
            String(localized: "night scene")
        case .satellite:
            String(localized: "satellite")
        case .exteriorView:
            String(localized: "exterior view")
        case .interiorView:
            String(localized: "interior view")
        case .closeUp:
            String(localized: "close-up")
        case .action:
            String(localized: "action")
        case .performing:
            String(localized: "performing")
        case .posing:
            String(localized: "posing")
        case .symbolic:
            String(localized: "symbolic")
        case .offBeat:
            String(localized: "off-beat")
        case .movieScene:
            String(localized: "movie scene")
        }
    }
}
