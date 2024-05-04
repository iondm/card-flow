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
        
    var vm: QuestionSelectionInputVM
    
    init(vm: QuestionSelectionInputVM) {
        self.vm = vm
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    switch vm.kind {
                        
                    case .section:
                        TextField(
                            "Name",
                            text: $sectionName
                        )
                        
                    case .question:
                        TextField(
                            "Question",
                            text: $question
                        )
                        
                        TextField(
                            "Answer",
                            text: $answer
                        )
                    }
                }
            }
            .navigationTitle(vm.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Add", action: save)
                }
            }
        }
    }
    
    func save() {
        switch vm.kind {
        case .section:
            vm.saveSection(section: sectionName)
            
        case .question(let section):
            vm.saveGameCard(question: question, answer: answer, section: section)
        }
        
        dismiss()
    }
}

enum QuestionSelectionKind {
    case section
    case question(section: GameSection)
}

class QuestionSelectionInputVM {
    let kind: QuestionSelectionKind
    let updateListFunction: (() -> Void)

    
    var title: String {
        switch kind {
        case .question:
            "New Question"
            
        case .section:
            "New Section"
        }
    }
    
    init(
        kind: QuestionSelectionKind,
        updateListFunction: @escaping (() -> Void)
    ) {
        self.kind = kind
        self.updateListFunction = updateListFunction
    }
    
    func saveSection(section: String) {
        _ = DataManager.shared.createSection(name: section)
    }
    
    func saveGameCard(question: String, answer: String, section: GameSection) {
        _ = DataManager.shared.createGameCard(
            question: question,
            answer: answer,
            section: section
        )
        updateListFunction()
    }
}

#Preview {
    QuestionSelectionInputView(vm: .init(
        kind: .section, updateListFunction: {}
    ))
}
