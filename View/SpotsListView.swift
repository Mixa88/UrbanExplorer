//
//  SpotsListView.swift
//  UrbanExplorer
//
//  Created by Михайло Тихонов on 31.08.2025.
//

import SwiftUI

struct SpotsListView: View {
    
    @Bindable var viewModel: MainMapView.ViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.spots) { spot in
                    NavigationLink {
                        
                        EditSpotView(spot: spot, onSave: { updatedSpot in
                            viewModel.update(spot: updatedSpot)
                        }, onDelete: { spotToDelete in
                            viewModel.deleteSpot(spot: spotToDelete)
                        })
                    } label: {
                        
                        HStack {
                            if let imageData = spot.imageData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            
                            VStack(alignment: .leading) {
                                Text(spot.name)
                                    .font(.headline)
                                RatingView(rating: .constant(spot.rating)) // Отображаем рейтинг
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteSpotFromList)
            }
            .navigationTitle("My Spots")
        }
    }
    
}

#Preview {
    SpotsListView(viewModel: MainMapView.ViewModel())
}
