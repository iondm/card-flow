//
//  Created by ion.dm on 27/06/23.
//

import SwiftUI

// TODO: Improve the animation, by watching the swiftHeroes Video.

struct GameCardView<InnerView: View>: View {
    var backView: AnyView

    @ObservedObject var vm: GameCardVM
    
    @ViewBuilder var view: InnerView;
    
    var body: some View {
        ZStack {
            GameCardStructure(vm: vm, isFront: true) { view }
            GameCardStructure(vm: vm, isFront: false) { backView }
        }

    }
}


private struct GameCardStructure<InnerView: View>: View {
    @ObservedObject var vm: GameCardVM
    var frontColor: Color = ColorManager.Silver
    var backColor: Color = ColorManager.Carrot
    var isFront: Bool

    @ViewBuilder var view: InnerView;
    var body: some View {
        view
            .gameCard(color: isFront ? frontColor : backColor)
            .rotation3DEffect(
                Angle( degrees: isFront ? vm.frontDegree : vm.backDegree),
                axis: (x: 0, y: 1, z: 0)
            )
    }
}

