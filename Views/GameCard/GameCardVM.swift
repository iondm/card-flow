//
//  Created by ion.dm on 10/07/23.
//

import Foundation
import SwiftUI

class GameCardVM : ObservableObject {
    let durationAndDelay : CGFloat = 0.3
    
    @Published var cardData: GameCard
    
    @Published var backDegree: Double = 0.0
    @Published var frontDegree: Double = -90.0
    @Published var transitionTrigger: Bool = false
    
    var isFlipped = false
    
    init(model: GameCard) {
        self.cardData = model
    }
    
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration:durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    
}
