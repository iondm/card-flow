//
//  Created by ion.dm on 26/06/23.
//

import SwiftUI

@main
struct CardFlowApp: App {
    
    var body: some Scene {
        WindowGroup {
            StartingView()
        }
    }
}

// A view used to start or test the application.
struct StartingView: View {
    @State var isFrontCardView: Bool = false
    
    var vm = GameCardVM(model: GameCard())
    
    var frontView = Text("front")
    var backView = AnyView(Text("back"))
    
    var body: some View {
        VStack {
            GameCardView(backView: backView, vm: vm) {
                frontView
            }
            .onTapGesture {
                vm.flipCard()
            }
            
            Button(
                action: { vm.flipCard()},
                label: {Text("Click for the magic!") }
            )
        }.background(ColorManager.Orange)
    }
}

struct CardFlowApp_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}

