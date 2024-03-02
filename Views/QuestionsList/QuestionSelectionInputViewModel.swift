//
//  QuestionSelectionInputViewModel.swift
//  CardFlow
//
//  Created by Drumea Ion on 29/01/24.
//

import Foundation
import SwiftUI

enum QuestionSelectionKind {
    case section
    case question
}

class QuestionSelectionInputViewModel {
    var kind: QuestionSelectionKind
    
    var title: String {
        switch kind {
        case .question:
            "New Question"
            
        case .section:
            "New Section"
        }
    }
    
    init(kind: QuestionSelectionKind) {
        self.kind = kind
    }
    
    func saveSection(_ section: String) {
        DataManager.addSection(section)
    }
    
    func saveGameCard(_ gameCard: GameCard, section: String) {
        DataManager.addGameCard(gameCard, to: section)
    }
}
