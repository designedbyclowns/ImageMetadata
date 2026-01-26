import Foundation

enum Shared {
    /// Access resources in the `Shared` targets bundle
    static func url(forResource name: String, withExtension ext: String) -> URL? {
        Bundle.module.url(forResource: name, withExtension: ext)
    }
}
