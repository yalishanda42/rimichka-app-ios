//
//  SearchRhymesView.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct SearchRhymesView: View {
    
    let searchState: AppState.SearchState
    let onTapSearch: (String) -> Void
    
    @State private var searchQuery = ""
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("Напиши дума...", text: $searchQuery)
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
                     
                            if isEditing && !searchQuery.isEmpty {
                                Button(action: {
                                    searchQuery = ""
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
                    onTapSearch(searchQuery)
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
    
    var stateDependentView: some View {
        switch searchState {
        case .initial:
            return AnyView(Text("Потърси някоя рима."))
        case .loading:
            return AnyView(ProgressView())
        case .failed(errorMessage: let message):
            return AnyView(Text(message).foregroundColor(.red))
        case .loaded(let rhymes):
            return AnyView(RhymesListView(rhymesList: rhymes))
        }
    }
}

struct SearchRymesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRhymesView(searchState: .initial, onTapSearch: {_ in })
        SearchRhymesView(searchState: .loading, onTapSearch: {_ in })
        SearchRhymesView(searchState: .loaded(serchResults: Array(repeating: .init(word: "Test", strength: 0, parentWord: "Example"), count: 20)), onTapSearch: {_ in })
        SearchRhymesView(searchState: .failed(errorMessage: "Error"), onTapSearch: {_ in })
    }
}
