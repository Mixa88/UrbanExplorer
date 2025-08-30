//
//  EditSpotView-ViewModel.swift
//  UrbanExplorer
//
//  Created by Михайло Тихонов on 29.08.2025.
//

import Foundation
import _PhotosUI_SwiftUI

extension EditSpotView {
    @Observable
    class ViewModel {
        
        var spot: Spot
        var name: String
        var notes: String
        var rating: Int
        
        
        var selectedPhotoItem: PhotosPickerItem?
        var selectedPhotoData: Data?
        
        init(spot: Spot) {
            self.spot = spot
            self.name = spot.name
            self.notes = spot.notes
            self.rating = spot.rating
            self.selectedPhotoData = spot.imageData
        }
        
        @MainActor
                func loadImage() async {
                    do {
                        if let data = try await selectedPhotoItem?.loadTransferable(type: Data.self) {
                            selectedPhotoData = data
                        }
                    } catch {
                        print("Failed to load image: \(error)")
                    }
                }
        
        func save() -> Spot {
            var newSpot = spot
            newSpot.name = name
            newSpot.notes = notes
            newSpot.id = UUID()
            newSpot.rating = rating
            newSpot.imageData = selectedPhotoData
            return newSpot
        }
    }
}
