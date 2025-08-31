//
//  ContentView.swift
//  UrbanExplorer
//
//  Created by Михайло Тихонов on 27.08.2025.
//

import SwiftUI
import MapKit

struct MainMapView: View {
   
    @Bindable var viewModel: ViewModel
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    
    var body: some View {
        NavigationStack {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.spots) { spot in
                        Annotation(spot.name, coordinate: spot.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.orange)
                                .frame(width: 38, height: 38)
                                .background(.white)
                                .clipShape(.circle)
                                .onTapGesture {
                                    viewModel.selectedSpot = spot
                                }
                                
                        }
                    }
                }
                .mapStyle(viewModel.mapStyle)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addSpot(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedSpot) { spot in
                    EditSpotView(
                        spot: spot,
                        onSave: { updatedSpot in
                            viewModel.update(spot: updatedSpot)
                        },
                        onDelete: { spotToDelete in // <-- Теперь мы принимаем аргумент
                            viewModel.deleteSpot(spot: spotToDelete) // <-- И передаем его в ViewModel
                        }
                    )
                }
                .toolbar {
                    Button("Map Style") {
                        viewModel.isHybrid.toggle()
                    }
                }
                
            }
            .navigationTitle("Urban Explorer")
        }
    }
}

#Preview {
    MainMapView(viewModel: MainMapView.ViewModel())
}
