//
//  SessionViewModel.swift
//  CardFlow
//
//  Created by Drumea Ion on 18/01/24.
//

import SwiftUI

class SessionVM: ObservableObject {
    let section: GameSection
    let cards: [GameCard]
    let colorPool = [ColorManager.Carrot, ColorManager.Silver, ColorManager.BelizeHole, ColorManager.SunFlower]
    var currentCardIndex: Int = 0
    
    var isPrevieousCardAvailable: Bool {
        currentCardIndex > 0
    }

    init(section: GameSection, cards: [GameCard]) {
        self.section = section
        self.cards = cards
    }
    
    func gameCardColor(index: Int) -> Color {
        return colorPool[index % colorPool.count]
    }
}
