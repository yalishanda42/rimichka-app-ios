//
//  SearchRhymesView.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct SearchRhymesView: View {
    
    @EnvironmentObject var store: AppStore
    
    let searchState: AppState.SearchState
    
    @State private var searchQuery = ""
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("Напиши дума...", text: $searchQuery)
                    .autocapitalization(.none)
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
                    store.send(.search(searchQuery))
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
            return Text("Потърси някоя рима.").eraseToAnyView()
        case .loading:
            return ProgressView().eraseToAnyView()
        case .failed(errorMessage: let message):
            return Text(message).foregroundColor(.red).eraseToAnyView()
        case .loaded(let rhymes):
            return RhymesListView(rhymesList: rhymes, showParentWord: false).eraseToAnyView()
        }
    }
}

struct SearchRymesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRhymesView(searchState: .initial)
        SearchRhymesView(searchState: .loading)
        SearchRhymesView(searchState: .loaded(serchResults: Array(repeating: .init(word: "Test", parentWord: "Example"), count: 20)))
        SearchRhymesView(searchState: .failed(errorMessage: "Error"))
    }
}
