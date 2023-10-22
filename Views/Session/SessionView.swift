//
// Created by ion.dm on 30/07/23.
//

import SwiftUI

struct SessionView: View {
    @State var isFrontCardView: Bool = false

    var frontView: AnyView
    var backView: AnyView
    
    let gameCardVM = GameCardVM(model: GameCard())
    
    init() {
        let gameCard = GameCard()
        
        self.frontView = AnyView(QuestionCardView(
            question: gameCard.question,
            answer: gameCard.answer
        ))
        self.backView = AnyView(
            Text(gameCard.answer)
        )
    }
    
    init(frontView: AnyView, backView: AnyView) {
        self.frontView = frontView
        self.backView = backView
    }
    
    var body: some View {
        VStack {
            VStack {
                
                GameCardView(
                    backView: backView,
                    frontView: frontView,
                    vm: gameCardVM)
                .frame(maxHeight: UIScreen.screenHeight * 0.48 )
                .padding(30)
                
                Button(
                    action: { gameCardVM.flipCard() },
                    label: {Text("Click for the magic!") }
                )
                
                Spacer()
                
            }
            .background(ColorManager.backgroundColor)
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}

