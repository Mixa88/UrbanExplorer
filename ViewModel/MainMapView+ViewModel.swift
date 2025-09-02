//
//  MainMapView+ViewModel.swift
//  UrbanExplorer
//
//  Created by Михайло Тихонов on 27.08.2025.
//

import Foundation
import MapKit
import CoreLocation
import SwiftUI

extension MainMapView.ViewModel: CLLocationManagerDelegate {
    
}

extension MainMapView {
    @Observable
    class ViewModel: NSObject {
        
        private(set) var spots: [Spot]
        var selectedSpot: Spot?
    
        let savePath = URL.documentsDirectory.appending(path: "SavedSpots")
        var isHybrid: Bool = false
        
        
        private var locationManager: CLLocationManager!
        var mapRegion = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        )
        
        
        var mapStyle: MapStyle {
            if isHybrid {
                return .hybrid
            } else {
                return .standard
            }
        }
        
        override init() {
            do {
                let data = try Data(contentsOf: savePath)
                spots = try JSONDecoder().decode([Spot].self, from: data)
            } catch {
                spots = []
            }
            
            super.init()
            
            setupLocationManager()
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
            let newSpot = Spot(id: UUID(), name: "New Spot", notes: "", rating: 4, latitude: coordinate.latitude, longitude: coordinate.longitude)
            spots.append(newSpot)
            save()
        }
        
        func deleteSpot(spot: Spot) {
            if let index = spots.firstIndex(of: spot) {
                spots.remove(at: index)
                save()
            }
        }
        
        func deleteSpotFromList(at offsets: IndexSet) {
            spots.remove(atOffsets: offsets)
            save()
        }
        
        private func setupLocationManager() {
                    locationManager = CLLocationManager()
                    locationManager?.delegate = self
                }
        
        func checkLocationAuthorization() {
                    guard let locationManager = locationManager else { return }

                    switch locationManager.authorizationStatus {
                    case .notDetermined:
                        locationManager.requestWhenInUseAuthorization()
                    case .restricted:
                        print("Your location is restricted.")
                    case .denied:
                        print("You have denied location permission. Please enable it in settings.")
                    case .authorizedAlways, .authorizedWhenInUse:
                        
                        if let location = locationManager.location {
                            
                            let newRegion = MKCoordinateRegion(
                                center: location.coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                            )

                            
                            mapRegion = .region(newRegion)
                        }
                    @unknown default:
                        break
                    }
                }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
                    checkLocationAuthorization()
                }
        
    }
}
