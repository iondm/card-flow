//
// Created by ion.dm on 30/07/23.
//

import SwiftUI

struct SessionView: View {
    
    @ObservedObject var vm: SessionVM = SessionVM()
    
    @State var isFrontCardView: Bool = false
    @State var transitionTrigger: Bool = true
    @State var isCardSwapButtonDisables: Bool = false
    @State var isLeftTransiction: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    if transitionTrigger {
                        if isLeftTransiction {
                            GameCardView(gameCardVM: vm.gameCardVM)
                                .transactionLeadingIn()
                        } else {
                            GameCardView(gameCardVM: vm.gameCardVM)
                                .transactionTrailingOut()
                        }
                    } else {
                        if isLeftTransiction {
                            GameCardView(gameCardVM: vm.gameCardVM)
                                .transactionLeadingIn()
                        } else {
                            GameCardView(gameCardVM: vm.gameCardVM)
                                .transactionTrailingOut()
                        }
                    }
                }
                .onTapGesture {
                    vm.gameCardVM.flipCard()
                }
                
                HStack {
                    Spacer()
                    
                    Image(systemName: "arrow.left.circle")
                        .onTapGesture { transictionAnimation(isLeftTransiction: true) }
                        .disabled(isCardSwapButtonDisables || !vm.isPrevieousCardAvailable)
                        .scaleEffect(
                             1.50
                        )
                        .foregroundColor(vm.isPrevieousCardAvailable ? .blue : .gray)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right.circle")
                        .onTapGesture{ transictionAnimation(isLeftTransiction: false) }
                        .disabled(isCardSwapButtonDisables || !vm.isNextCardAvailable)
                        .scaleEffect(1.50)
                        .foregroundColor(vm.isNextCardAvailable ? .blue : .gray)
                    
                    Spacer()
                }
                .padding(30)
            }
        }
        .padding(.top, 50)
        .padding(.bottom, 80)
        .background(
            LinearGradient(gradient: Gradient(colors: [ColorManager.WetAsf, ColorManager.Midnight, ColorManager.Pomegranate]), startPoint: .topLeading, endPoint: .bottomTrailing)
          )
        
    }
    
    func transictionAnimation(isLeftTransiction: Bool) {
        guard isLeftTransiction && vm.isPrevieousCardAvailable || !isLeftTransiction && vm.isNextCardAvailable else {
            return
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            if isLeftTransiction {
                vm.previousQuestion()
            } else {
                vm.nextQuestion()
            }
        }
 
        
        self.isLeftTransiction = isLeftTransiction
        isCardSwapButtonDisables = true
        
        withAnimation(.linear(duration: 0.35)) {
            transitionTrigger.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            isCardSwapButtonDisables = false
        }
    }
    
}

#Preview {
    SessionView(vm: SessionVM(isDebug: true))
}
