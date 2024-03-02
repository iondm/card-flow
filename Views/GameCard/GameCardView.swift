//
//  Created by ion.dm on 27/06/23.
//

import SwiftUI

// TODO: Improve the animation, by watching the swiftHeroes Video.

struct GameCardView: View {
    @ObservedObject private var vm: GameCardVM
    
    init(gameCardVM: GameCardVM) {
        vm = gameCardVM
    }

    var body: some View {
        HStack {
            ZStack {
                GameCardStructure(vm: vm, isFrontUp: true) {
                    Text(vm.cardData.question)                }
                
                GameCardStructure(vm: vm, isFrontUp: false) {
                    Text(vm.cardData.answer)
                }
            }
        }

    }
}

private struct GameCardStructure<InnerView: View>: View {
    @ObservedObject var vm: GameCardVM
    var backColor: Color = ColorManager.Carrot
    var frontColor: Color = ColorManager.Carrot
    var isFrontUp: Bool

    @ViewBuilder var view: InnerView;
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                view
                Spacer()
            }
            Spacer()
        }                    
        .gameCard(color: isFrontUp ? frontColor : backColor)
        .rotation3DEffect(
            Angle( degrees: !isFrontUp ? vm.frontDegree : vm.backDegree),
            axis: (x: 0, y: 1, z: 0)
        )

    }
}

#Preview {
    GameCardView(gameCardVM: GameCardVM(model: GameCard()))
}
