//
//  SessionViewModel.swift
//  CardFlow
//
//  Created by Drumea Ion on 18/01/24.
//

import SwiftUI

class SessionVM: ObservableObject {
    @Published var gameCardVM = GameCardVM(model: GameCard())
    
    var gameCards: [GameCard] = []
    
    var currentCardIndex: Int = 0
    
    var isNextCardAvailable: Bool {
        if (currentCardIndex + 1) < gameCards.count {
            return true
        }
        return false
    }
    
    var isPrevieousCardAvailable: Bool {
        currentCardIndex > 0
    }

    init(isDebug: Bool = false) {
        if isDebug {
            gameCards = [GameCard()]
            gameCardVM = GameCardVM(model: GameCard())
            return
        }
        
        let sections = DataManager.getSections()
        gameCards = sections[sections.keys.first ?? ""] ?? []
        
        if currentCardIndex < gameCards.count {
            gameCardVM = GameCardVM(model: gameCards[currentCardIndex])
        }
    }
    
    func nextQuestion() {
        guard isNextCardAvailable else {
            return
        }
        
        currentCardIndex += 1
        
        if currentCardIndex < gameCards.count {
            gameCardVM = GameCardVM(model: gameCards[currentCardIndex])
        }
    }
    
    func previousQuestion() {
        guard isPrevieousCardAvailable else {
            return
        }
        
        currentCardIndex -= 1
        
        if currentCardIndex < gameCards.count {
            gameCardVM = GameCardVM(model: gameCards[currentCardIndex])
        }
    }
}
