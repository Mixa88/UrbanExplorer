//
//  AppTabView.swift
//  UrbanExplorer
//
//  Created by Михайло Тихонов on 31.08.2025.
//

import SwiftUI

struct AppTabView: View {
    
    @State private var viewModel = MainMapView.ViewModel()
    
    var body: some View {
        TabView {
            MainMapView(viewModel: viewModel)
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
            
            SpotsListView(viewModel: viewModel)
                .tabItem {
                    Label("Spots", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    AppTabView()
}
