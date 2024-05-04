//
// Created by ion.dm on 30/07/23.
//

import SwiftUI

struct SessionView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: SessionVM
    
    @State var isFrontCardView: Bool = false
    @State var isCardSwapButtonDisables: Bool = false
    @State var showBackButton: Bool = false
    
    var BackButton: some View {
        Image(systemName: "arrowshape.backward.fill")
            .scaleEffect(1.30)
            .foregroundStyle(ColorManager.firstColor)
            .onTapGesture { showBackButton.toggle() }
            .alert(
                isPresented: $showBackButton ) {
                    Alert(
                        title: Text("Closing session"),
                        message: Text("Are you sure you want to proceed?"),
                        primaryButton: .destructive(Text("OK")) {
                            dismiss()
                        }, // Destructive style for OK
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                }
    }
    
    var body: some View {
        VStack {
            HStack {
                BackButton
                
                Spacer()
                
                Text(vm.section.nameDescription)
                    .foregroundColor(.white)
                    .bold()
                    .font(.title)
                
                Spacer()
                
                BackButton.hidden()
            }.padding(.bottom, 30)
            
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
        .padding(.bottom, 100)
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
