//
//  SessionViewModel.swift
//  CardFlow
//
//  Created by Drumea Ion on 18/01/24.
//

import SwiftUI

class SessionVM: ObservableObject {
    let gameCardVMs: [GameCardVM]
    let title: String
    var currentCardIndex: Int = 0
    
    var isPrevieousCardAvailable: Bool {
        currentCardIndex > 0
    }

    init(isDebug: Bool = false) {
        if isDebug {
            gameCardVMs = [GameCardVM(model: GameCard()), GameCardVM(model: GameCard()), GameCardVM(model: GameCard())]
            title = "Test"
            return
        }
        
        let sections = DataManager.getSections()
        let gameCards = sections[sections.keys.first ?? ""] ?? []
        
        title = sections.keys.first ?? ""
        gameCardVMs = gameCards.map {
            GameCardVM(model: $0)
        }
    }
}
