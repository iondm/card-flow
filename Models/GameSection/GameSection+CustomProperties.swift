//
//  GameSection+CustomProperties.swift
//  CardFlow
//
//  Created by Drumea Ion on 03/05/24.
//

import Foundation

extension GameSection {
    
    var nameDescription: String { name ?? "" }
    
    var cardsArray: [GameCard] {
        var cards = DataManager.shared.gameCards(section: self)
        cards.sort(by: { $0.order < $1.order })
        return cards
    }
    
}
