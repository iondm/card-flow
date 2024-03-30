//
// Created by ion.dm on 30/07/23.
//

import SwiftUI

struct SessionView: View {
    
    @ObservedObject var vm: SessionVM
    
    @State var isFrontCardView: Bool = false
    @State var isCardSwapButtonDisables: Bool = false
    @State var title: String = "Title"
    var body: some View {
        VStack {
            Text(vm.title)
                .foregroundColor(.white)
                .font(.title)
                .padding(.bottom, 30)
            
            ZStack {
                ForEach(0..<vm.gameCardVMs.count, id: \.self) { index in
                    GameCardView(gameCardVM: vm.gameCardVMs[index])
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
