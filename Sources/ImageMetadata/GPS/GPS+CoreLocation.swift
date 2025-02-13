import CoreLocation

extension GPS {
    /// The geographic coordinate of the image.
    ///
    /// > Returns nil if the `CLLocationCoordinate2D` is invalid.
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude, let longitude else { return nil }
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        guard CLLocationCoordinate2DIsValid(coordinate) else { return nil }
        return coordinate
    }
    
    /// The geographic location of the image.
    ///
    /// > Returns nil if the `CLLocationCoordinate2D` is invalid.
    var location: CLLocation? {
        guard let coordinate else { return nil }
        return CLLocation(
            coordinate: coordinate,
            altitude: altitude ?? 0.0,
            horizontalAccuracy: horizontalPositioningError ?? 0.0,
            verticalAccuracy: 0.0,
            timestamp: date ?? .now
        )
    }
}
