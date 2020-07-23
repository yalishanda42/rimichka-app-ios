//
//  SearchRhymesView.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct SearchRhymesView: View {
    
    @StateObject var viewModel: SearchRhymesViewModel
    @State var isEditing = false
    
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
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                     
                            if isEditing && !viewModel.searchQuery.isEmpty {
                                Button(action: {
                                    viewModel.searchQuery = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    ).padding(.horizontal, 10)
                    .onTapGesture {
                        isEditing = true
                    }
                
                Button(action: {
                    isEditing = false
                    UIApplication.shared.endEditing()
                    viewModel.searchRequested.send()
                }, label: {
                    Text("Римувай")
                })
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }.padding()
            
            Spacer()
            
            stateDependentView
            
            Spacer()
        }
    }
}

struct SearchRymesView_Previews: PreviewProvider {
    
    static func testViewModel(withState state: SearchRhymesViewModel.SearchState) -> SearchRhymesViewModel {
        let result = SearchRhymesViewModel()
        result.state = state
        return result
    }
    
    static var previews: some View {
        SearchRhymesView(viewModel: testViewModel(withState: .initial))
        SearchRhymesView(viewModel: testViewModel(withState: .loading))
        SearchRhymesView(viewModel: testViewModel(withState: .loaded(rhymesResult: Array(repeating: .init(wrd: "Test", pri: 0), count: 20))))
        SearchRhymesView(viewModel: testViewModel(withState: .failed(errorMessage: "Error")))

    }
}
