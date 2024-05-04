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
            Text(vm.section.nameDescription)
                .foregroundColor(.white)
                .bold()
                .font(.title)
                .padding(.bottom, 30)
            
            ZStack {
                ForEach(0..<vm.section.cardsArray.count, id: \.self) { index in
                    GameCardView(
                        cardModel: vm.section.cardsArray[index],
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
    
    guard let section = DataManager.shared.sections().first  else {
        let section = DataManager.shared.mockupSection()
        
        return SessionView(vm: SessionVM(section: section, cards: section.cardsArray))
    }
    
    return SessionView(vm: SessionVM(section: section, cards: section.cardsArray))
}
