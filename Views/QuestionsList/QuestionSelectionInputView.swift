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
    @State var section: String = ""
    @State var question: String = ""
    @State var answer: String = ""
    
    let selectedSection: String
    
    var vm: QuestionSelectionInputViewModel
    
    init(kind: QuestionSelectionKind = .section, section: String = "") {
        self.vm = QuestionSelectionInputViewModel(kind: kind)
        self.selectedSection = section
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    switch vm.kind {
                        
                    case .section:
                        TextField(
                            "Name",
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
            vm.saveSection(section)

        case .question:
            vm.saveGameCard(GameCard(question, answer), section: selectedSection)
        }
        
        dismiss()
    }
}

#Preview {
    QuestionSelectionInputView(kind: .section)
}
