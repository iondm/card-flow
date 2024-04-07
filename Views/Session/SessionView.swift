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
            Text(vm.title.uppercased())
                .foregroundColor(.white)
                .bold()
                .font(.title)
                .padding(.bottom, 30)
            
            ZStack {
                ForEach(0..<vm.gameCards.count, id: \.self) { index in
                    GameCardView(
                        cardModel: vm.gameCards[index],
                        color: vm.gameCardColor(index: index)
                    )
                }
            }
        }
        .padding(.top, 20)
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
