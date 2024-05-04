//
//  QuestionSection.swift
//  CardFlow
//
//  Created by Drumea Ion on 02/05/24.
//

import SwiftUI
import Foundation

struct QuestionSection: View {
    @State private var question = ""
    @State private var answer = ""
    @State private var showAddGameCardView = false
    
    @Environment(\.editMode) private var editMode
    
    @ObservedObject var vm: QuestionSectionVM
    
    var AddGameCardButton: some View {
        Image(systemName: "plus.app")
            .scaleEffect(1.30)
            .foregroundStyle(ColorManager.firstColor)
            .onTapGesture { showAddGameCardView.toggle() }
            .sheet(
                isPresented: $showAddGameCardView,
                onDismiss: { vm.save()} ) {
                    QuestionSelectionInputView(vm: .init(
                        kind: .question(section: vm.section),
                        updateListFunction: vm.updateListFunction
                    ))
                        .presentationDetents([.fraction(0.3)])
                }
    }
    
    var RemoveSectionButton: some View {
        Image(systemName: "minus.circle")
            .foregroundStyle(.red)
            .scaleEffect(1.30)
            .onTapGesture {
                vm.removeSection()
            }
    }
    
    var body: some View {
        Section(header: HStack {
            if editMode?.wrappedValue.isEditing == true {
                RemoveSectionButton
            }
            
            Text(vm.section.nameDescription)
                .foregroundStyle(ColorManager.firstColor)
                .font(.system(size: 20))
                .padding(.trailing)
            
            Spacer()
            
            AddGameCardButton
        }
            .padding(.vertical, 10)
            .animation(.default, value: editMode?.wrappedValue)
        ) {
            ForEach(vm.cards) { gameCard in
                VStack {
                    HStack {
                        Text(gameCard.questionDescription)
                        Spacer()
                    }
                    HStack {
                        Text(gameCard.answerDescription)
                            .foregroundColor(Color.gray)
                        Spacer()
                    }
                }
            }
            .onDelete(perform: { index in
                vm.delete(index: index)
            })
            .onMove(perform: { newIndices, originindex in
                vm.move(originIndices: newIndices, toIndex: originindex)
            })
        }
    }
}

class QuestionSectionVM: ObservableObject {
    let section: GameSection
    let dataManager = DataManager.shared
    let updateListFunction: (() -> Void)
    var cards: [GameCard]
    
    init(
        section: GameSection,
        updateListFunction: @escaping (() -> Void)
    ) {
        self.section = section
        self.cards = section.cardsArray
        self.updateListFunction = updateListFunction
    }
    
    func delete(index: IndexSet) {
        index.forEach {
            dataManager.deleteGameCard(gameCard: cards[$0])
            cards.remove(at: $0)
        }
        save()
    }
    
    func move(originIndices: IndexSet, toIndex: Int) {
        cards.move(fromOffsets: originIndices, toOffset: toIndex)
        
        cards.enumerated().forEach {
            $0.element.order = Int32($0.offset)
        }
        
        DataManager.shared.save()
    }
    
    func removeSection() {
        dataManager.deleteSection(section: section)
        updateListFunction()
    }
    
    func save() {
        dataManager.save()
    }
}

#Preview {
    guard let section = DataManager.shared.sections().first else {
        return QuestionSection(
            vm: QuestionSectionVM(section: DataManager.shared.mockupSection()) {}
        )
    }
    
    return QuestionSection(
        vm: QuestionSectionVM(section: section)  {}
    )
}
