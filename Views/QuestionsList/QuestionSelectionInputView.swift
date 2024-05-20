//
//  SelectionInputView.swift
//  CardFlow
//
//  Created by Drumea Ion on 26/01/24.
//

import Foundation
import SwiftUI


struct QuestionSelectionInputView: View {
    @Environment(\.dismiss) var dismiss
    @State var sectionName: String = ""
    @State var question: String = ""
    @State var answer: String = ""
    @State var isGuessed: Bool = false
        
    var vm: QuestionSelectionInputVM
    
    init(vm: QuestionSelectionInputVM) {
        self.vm = vm
        
        switch vm.kind {
        case .gameCard(_, let gameCard):
            if let question = gameCard.question,
               let answer = gameCard.answer {
                _question = State(initialValue: question)
                _answer = State(initialValue: answer)
                _isGuessed = State(initialValue: gameCard.isGuessed)
            }
            
        default:
            break;
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    switch vm.kind {
                        
                    case .section:
                        TextField(
                            "Name",
                            text: $sectionName,
                            axis: .vertical
                        )
                        
                    case .newGameCard, .gameCard:
                        TextField(
                            "Question",
                            text: $question,
                            axis: .vertical
                        )
                        
                        TextField(
                            "Answer",
                            text: $answer,
                            axis: .vertical
                        )
                        
                        
                    }
                }
                if case .gameCard(_, let gameCard) = vm.kind {
                    Section {
                        Toggle(isOn: $isGuessed) {
                            Text("Is guessed")
                        }
                    }
                    
                    Button("Delete Game Card") {
                        vm.delete(gameCard: gameCard)
                        dismiss()
                    }
                }

            }
            .navigationTitle(vm.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save", action: save)
                }
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Cancel", action: { dismiss() })
                }
            }
        }
    }
    
    private func save() {
        switch vm.kind {
        case .section:
            vm.saveSection(section: sectionName)
            
        case .newGameCard(let section):
            vm.saveGameCard(question: question, answer: answer, section: section)
            
        case .gameCard(section: _, let gameCard):
            vm.update(gameCard: gameCard, question: question, answer: answer, isGuessed: isGuessed)
        }
        
        dismiss()
    }
}

enum QuestionSelectionKind {
    case section
    case newGameCard(section: GameSection)
    case gameCard(section: GameSection, gameCard: GameCard)
}

class QuestionSelectionInputVM {
    let kind: QuestionSelectionKind
    let updateList: (() -> Void)

    var title: String {
        switch kind {
        case .newGameCard:
            "New Flash Card"
            
        case .section:
            "New Section"
            
        case .gameCard:
            "Edit Flash Card"
        }
    }
    
    var isEnableDeleteButton: Bool {
        switch kind {
        case .gameCard:
            true
            
        case .section, .newGameCard:
            false
        }
    }
    
    init(
        kind: QuestionSelectionKind,
        updateListFunction: @escaping (() -> Void)
    ) {
        self.kind = kind
        self.updateList = updateListFunction
    }
    
    func saveSection(section: String) {
        _ = DataManager.shared.createSection(name: section)
        updateList()
    }
    
    func saveGameCard(question: String, answer: String, section: GameSection) {
        _ = DataManager.shared.createGameCard(
            question: question,
            answer: answer,
            section: section
        )
        updateList()
    }
    
    func update(gameCard: GameCard, question: String, answer: String, isGuessed: Bool) {
        gameCard.answer = answer
        gameCard.question = question
        gameCard.isGuessed = isGuessed
        DataManager.shared.save()
        updateList()
    }
    
    func delete(gameCard: GameCard) {
        DataManager.shared.deleteGameCard(gameCard: gameCard)
        updateList()
    }
}


#Preview {
    let section = DataManager.shared.mockupSection()
    let gameCard = DataManager.shared.mockupCards(section: section)[0]
    
    return QuestionSelectionInputView(vm: .init(
        kind: .gameCard(section: section,gameCard: gameCard), updateListFunction: {}
    ))
}
