//
//  SearchRymesView.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct SearchRymesView: View {
    
    @StateObject var viewModel: SearchRhymesViewModel
    
    var stateDependentView: some View {
        switch viewModel.state {
        case .initial:
            return AnyView(Text("Потърси някоя рима."))
        case .loading:
            return AnyView(ProgressView())
        case .failed(errorMessage: let message):
            return AnyView(Text(message).foregroundColor(.red))
        case .loaded:
            return AnyView(RhymesListView(viewModel: viewModel.rhymesListViewModel))
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Напиши дума...", text: $viewModel.searchQuery)
                Button(action: {
                    UIApplication.shared.endEditing()
                    viewModel.searchRequested.send()
                }, label: {
                    Text("Римувай ме")
                })
            }.padding()
            
            Spacer()
            
            stateDependentView
            
            Spacer()
        }
    }
}

struct SearchRymesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRymesView(viewModel: SearchRhymesViewModel())
    }
}
