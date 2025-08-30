//
//  EditSpotView.swift
//  UrbanExplorer
//
//  Created by Михайло Тихонов on 29.08.2025.
//

import SwiftUI

struct EditSpotView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: ViewModel
    
    var onSave: (Spot) -> Void
    var onDelete: (Spot) -> Void
    
    init(spot: Spot, onSave: @escaping (Spot) -> Void, onDelete: @escaping (Spot) -> Void) {
        self.onSave = onSave
        self.onDelete = onDelete
        
        _viewModel = State(initialValue: ViewModel(spot: spot))
        
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Spot name", text: $viewModel.name)
                    RatingView(rating: $viewModel.rating)
                }
                
                Section("Notes") {
                    TextEditor(text: $viewModel.notes)
                        .frame(minHeight: 75)
                }
                
                Section("Delete Spot") {
                    Button("Delete") {
                        onDelete(viewModel.spot)
                        dismiss()
                    }
                    .buttonStyle(.automatic)
                    .bold()
                }
            }
            .navigationTitle("Spot details")
            .toolbar {
                Button("Save") {
                    let newSpot = viewModel.save()
                    onSave(newSpot)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    EditSpotView(spot: .example, onSave: { _ in }, onDelete: { _ in })
}
