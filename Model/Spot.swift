//
//  Spot.swift
//  UrbanExplorer
//
//  Created by Михайло Тихонов on 27.08.2025.
//

import Foundation
import MapKit

struct Spot: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var notes: String
    var rating: Int
    var imageData: Data?
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func == (lhs: Spot, rhs: Spot) -> Bool {
        lhs.id == rhs.id
    }
    
    #if DEBUG
    static let example = Spot(
        id: UUID(),
        name: "Example Spot",
        notes: "This is an example spot.",
        rating: 4,
        latitude: 50.4501,
        longitude: 30.5234
    )
    #endif
}
