//
// Created by ion.dm on 30/07/23.
//

import SwiftUI

struct SessionView: View {
    
    @ObservedObject var vm: SessionVM = SessionVM()
    
    @State var isFrontCardView: Bool = false
    @State var isCardSwapButtonDisables: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<3) { n in
                    GameCardView(gameCardVM: vm.gameCardVM)
                }
                .onTapGesture {
                    vm.gameCardVM.flipCard()
                }
            }
        }
        .padding(.top, 80)
        .padding(.bottom, 140)
        .padding(.horizontal, 50)
        .background(
            LinearGradient(gradient: Gradient(colors: [ColorManager.WetAsf, ColorManager.Midnight, ColorManager.Pomegranate]), startPoint: .topLeading, endPoint: .bottomTrailing)
          )
        
    }
}

#Preview {
    SessionView(vm: SessionVM(isDebug: true))
}
