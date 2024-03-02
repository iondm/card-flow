//
//  QuestionList.swift
//  CardFlow
//
//  Created by Drumea Ion on 09/01/24.
//

import SwiftUI
import Foundation

struct QuestionList: View {
    @ObservedObject var vm = QuestionListVM()
    @State private var showAddSectionView = false
    
    var AddSection: some View {
        Button("Add Section") {
            showAddSectionView.toggle()
        }.sheet(
            isPresented: $showAddSectionView,
            onDismiss: { vm.waitAndUpdate()} ) {
                QuestionSelectionInputView(kind: .section)
                    .presentationDetents([.fraction(0.3)])
            }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(vm.sections.keys), id: \.self) { section in
                    QuestionSection(vm: vm, section: section, cards: vm.sections[section] ?? [])
                }
            }
            .navigationTitle("Questions")
            .navigationBarItems(
                leading: EditButton(),
                trailing: AddSection
            )
            .scrollContentBackground(.hidden)
            .background(ColorManager.backgroundGradient)
            .refreshable {
                print("Do your refresh work here")
                vm.updateData()
            }
        }
        .scrollContentBackground(.hidden)
        .accentColor(ColorManager.firstColor)
    }
}

private struct QuestionSection: View {
    @State private var question = ""
    @State private var answer = ""
    @State private var showAddGameCardView = false
    
    @ObservedObject var vm: QuestionListVM
    
    var section: String
    var cards: [GameCard]
    
    var AddGameCardButton: some View {
        Image(systemName: "plus.app")
            .scaleEffect(1.30)
            .foregroundStyle(.black)
            .onTapGesture { showAddGameCardView.toggle() }
            .sheet(
                isPresented: $showAddGameCardView,
                onDismiss: { vm.waitAndUpdate()} ) {
                    QuestionSelectionInputView(kind: .question, section: section)
                        .presentationDetents([.fraction(0.3)])
                }
    }
    
    var RemoveSectionButton: some View {
        Image(systemName: "minus.circle")
            .foregroundStyle(.black)
            .scaleEffect(1.30)
            .onTapGesture {
                vm.remove(section: section)
            }
    }
    
    var body: some View {
        Section(header: HStack {
            Text(section)
                .foregroundStyle(.black)
            RemoveSectionButton
            Spacer()
            AddGameCardButton
        }) {
            ForEach(cards) { gameCard in
                VStack {
                    HStack {
                        Text(gameCard.question)
                        Spacer()
                    }
                    HStack {
                        Text(gameCard.answer)
                            .foregroundColor(Color.gray)
                        Spacer()
                    }
                }
            }
            .onDelete(perform: { index in
                vm.delete(index: index, section: section)
            })
            .onMove(perform: { newIndex, originindex in
                vm.move(originIndex: newIndex, toOffset: originindex, section: section)
            })
        }
    }
}

#Preview {
    QuestionList()
}
