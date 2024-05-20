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
    @State private var showEditGameCardView = false
    @State private var showSessionView = false
    
    @Environment(\.editMode) private var editMode
    
    @ObservedObject var vm: QuestionSectionVM
    
    var AddGameCardButton: some View {
        Image(systemName: "plus.app")
            .scaleEffect(1.40)
            .foregroundStyle(ColorManager.firstColor)
            .onTapGesture { showAddGameCardView.toggle() }
            .sheet(
                isPresented: $showAddGameCardView) {
                    QuestionSelectionInputView(vm: .init(
                        kind: .newGameCard(section: vm.section),
                        updateListFunction: vm.updateListFunction
                    ))
                }
    }
    
    var StartSessionButton: some View {
        Image(systemName: "play.circle")
            .scaleEffect(1.40)
            .foregroundStyle(ColorManager.firstColor)
            .onTapGesture { showSessionView.toggle() }
            .fullScreenCover(isPresented: $showSessionView) {
                SessionView(vm: SessionVM(section: vm.section, cards: vm.cards))
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
    
    var ShuffleCardsButton: some View {
        Image(systemName: "shuffle.circle")
            .scaleEffect(1.30)
            .foregroundStyle(ColorManager.firstColor)
            .onTapGesture { vm.shuffleCards() }
    }
    
    var EditGameCardButton: some View {
        Image(systemName: "square.and.pencil")
            .foregroundStyle(.gray)
            .scaleEffect(1.30)
        .padding(.trailing, 6)    }
    
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
            
            if editMode?.wrappedValue.isEditing == true {
                                
                ShuffleCardsButton
                    .padding(.trailing, 10)
                                
                AddGameCardButton
                
            } else {
                
                StartSessionButton
                
            }
        }
            .animation(.easeInOut.delay(-0.1), value: editMode?.wrappedValue)
            .sheet(
                isPresented: $showEditGameCardView) {
                    QuestionSelectionInputView(vm: .init(
                        kind: .gameCard(section: vm.section, gameCard: vm.selectedGameCard!),
                        updateListFunction: vm.updateListFunction
                    ))
                }
        ) {
            ForEach(vm.cards) { gameCard in
                HStack {
                    if editMode?.wrappedValue.isEditing == true {
                        EditGameCardButton.onTapGesture {                            
                            vm.selectedGameCard = gameCard
                            showEditGameCardView.toggle()
                        }
                        
                    }
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
                
            }
            .onMove(perform: { newIndices, originindex in
                vm.move(originIndices: newIndices, toIndex: originindex)
            }).animation(.easeInOut.delay(-0.1), value: editMode?.wrappedValue)
        }
    }
}

class QuestionSectionVM: ObservableObject {
    let section: GameSection
    let dataManager = DataManager.shared
    let updateListFunction: (() -> Void)
    var cards: [GameCard]
    var selectedGameCard: GameCard? = nil
    
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
    
    func shuffleCards() {
        cards.shuffle()
        
        cards.enumerated().forEach { offset, card in
            card.order = Int32(offset)
        }
        dataManager.save()
        updateListFunction()
    }
}
