//
//  Created by ion.dm on 27/06/23.
//

import SwiftUI

// TODO: Improve the animation, by watching the swiftHeroes Video.

struct GameCardView: View {
    var backView: AnyView
    var frontView: AnyView

    @ObservedObject var vm: GameCardVM
    
    var body: some View {
        HStack {
            ZStack {
                GameCardStructure(vm: vm, isFrontUp: true) { frontView }
                GameCardStructure(vm: vm, isFrontUp: false) { backView }
            }
        }

    }
}


private struct GameCardStructure<InnerView: View>: View {
    @ObservedObject var vm: GameCardVM
    var backColor: Color = ColorManager.Orange
    var frontColor: Color = ColorManager.SunFlower
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
