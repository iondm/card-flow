//
//  SelectionInputView.swift
//  CardFlow
//
//  Created by Drumea Ion on 26/01/24.
//

import Foundation
import SwiftUI


struct QuestionSelectionInputView: View {
    @State var section: String = ""
    @State var question: String = ""
    @State var answer: String = ""
    
    var vm: QuestionSelectionInputViewModel
    
    @Environment(\.dismiss) var dismiss
    
    init(kind: QuestionSelectionKind = .section) {
        self.vm = QuestionSelectionInputViewModel(kind: kind)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    switch vm.kind {
                        
                    case .section:
                        TextField(
                            "Section",
                            text: $section
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
            .navigationTitle(vm.isSectionTitle)
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
            vm.saveSection(section)

        case .question:
            vm.saveGameCard(GameCard(question, answer), section: section)
        }
        
        dismiss()
    }
}

#Preview {
    QuestionSelectionInputView(kind: .section)
}
