//
//  EditSpotView-ViewModel.swift
//  UrbanExplorer
//
//  Created by Михайло Тихонов on 29.08.2025.
//

import Foundation

extension EditSpotView {
    @Observable
    class ViewModel {
        
        var spot: Spot
        var name: String
        var notes: String
        
        init(spot: Spot) {
            self.spot = spot
            self.name = spot.name
            self.notes = spot.notes
        }
        
        func save() -> Spot {
            var newSpot = spot
            newSpot.name = name
            newSpot.notes = notes
            newSpot.id = UUID()
            return newSpot
        }
    }
}
