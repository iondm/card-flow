//
//  Created by ion.dm on 26/06/23.
//

import SwiftUI

@main
struct CardFlowApp: App {
    var gameCard = GameCard()
    
    // Application start point.
    var body: some Scene {
        WindowGroup {
            SessionView(
                frontView:  AnyView(
                    QuestionCardView(
                        question: gameCard.question,
                        answer: gameCard.answer
                    )
                ),
                backView: AnyView(
                    Text(gameCard.answer)
                )
            )
        }
    }
}

struct CardFlowApp_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}

