//
//  SessionViewModel.swift
//  CardFlow
//
//  Created by Drumea Ion on 18/01/24.
//

import SwiftUI

class SessionVM: ObservableObject {
    let gameCards: [GameCard]
    let title: String
    let colorPool = [ColorManager.Carrot, ColorManager.Silver, ColorManager.BelizeHole, ColorManager.SunFlower]
    var currentCardIndex: Int = 0
    
    var isPrevieousCardAvailable: Bool {
        currentCardIndex > 0
    }

    init(isDebug: Bool = false) {
        if isDebug {
            gameCards = [GameCard(), GameCard(), GameCard()]
            title = "Test"
            return
        }
        
        let sections = DataManager.getSections()
        gameCards = sections[sections.keys.first ?? ""] ?? []

        title = sections.keys.first ?? ""
    }
    
    func gameCardColor(index: Int) -> Color {
        return colorPool[index % colorPool.count]
    }
}
