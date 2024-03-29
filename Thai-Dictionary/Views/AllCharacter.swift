//
//  AllCharacter.swift
//  Thai-Dictionary
//
//  Created by Bandit Silachai on 8/12/23.
//

import SwiftUI

struct AllCharacter: View {
    @EnvironmentObject private var vm: VocabularyViewModel
    
    var body: some View {
        NavigationView(content: {
            List {
                ForEach(vm.thaiAlphabet, id: \.self) { item in
                    NavigationLink {
                        DetailCharacter(character: item.character)
                    } label: {
                        Text(item.character)
                    }
                }
                .font(.title3)
                .fontWeight(.light)
            }
            .listStyle(.plain)
            .navigationTitle("คำศัพท์ตามอักษร")
        })
    }
}

#Preview {
    AllCharacter()
}

struct DetailCharacter: View {
    @EnvironmentObject var vm: VocabularyViewModel
    @State var character: String
    
    var body: some View {
        List {
            if vm.isBusy {
                ProgressView()
            }
            if let wordByCharacter = vm.wordByCharacter {
                ForEach(wordByCharacter, id: \.self) { item in
                    NavigationLink {
                        DetailView(vocab: item)
                    } label: {
                        Text(item)
                            .fontWeight(.light)
                            .font(.title3)
                    }
                    
                }
            }
        }
        .navigationTitle(character)
        .listStyle(.plain)
        .onAppear(perform: {
            vm.findByCharacter(character: character)
        })
        
    }
}
