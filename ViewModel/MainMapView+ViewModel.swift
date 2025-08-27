//
//  MainMapView+ViewModel.swift
//  UrbanExplorer
//
//  Created by Михайло Тихонов on 27.08.2025.
//

import Foundation
import MapKit
import CoreLocation
import LocalAuthentication
import SwiftUI

extension MainMapView {
    @Observable
    class ViewModel {
        
        private(set) var spots: [Spot]
        var selectedSpot: Spot?
        
        let savePath = URL.documentsDirectory.appending(path: "SavedSpots")
        
        var isHybrid: Bool = false
        var mapStyle: MapStyle {
            if isHybrid {
                return .hybrid
            } else {
                return .standard
            }
        }
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                spots = try JSONDecoder().decode([Spot].self, from: data)
            } catch {
                spots = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(spots)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Error saving spots: \(error)")
            }
        }
        
        func update(spot: Spot) {
            guard let selectedSpot else { return }
            
            if let index = spots.firstIndex(of: selectedSpot) {
                spots[index] = spot
                save()
            }
        }
        
        func addSpot(at coordinate: CLLocationCoordinate2D) {
            let newSpot = Spot(id: UUID(), name: "New Spot", notes: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
            spots.append(newSpot)
            save()
        }
        
    }
}
