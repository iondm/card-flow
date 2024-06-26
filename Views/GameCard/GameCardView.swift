//
//  Created by ion.dm on 27/06/23.
//

import SwiftUI

struct GameCardView: View {
    @ObservedObject private var vm: GameCardVM
    
    init(cardModel: GameCard, color: Color) {
        vm = GameCardVM(model: cardModel, color: color)
    }
    
    var body: some View {
        HStack {
            ZStack {
                GameCardStructure(vm: vm, color: vm.color, isFrontUp: true) {
                    Text(vm.cardData.questionDescription)
                        .foregroundColor(.black)
                }
                
                GameCardStructure(vm: vm, color: vm.color, isFrontUp: false) {
                    Text(vm.cardData.answerDescription)
                        .foregroundColor(.black)
                }
            }
        }
        
    }
}

private struct GameCardStructure<InnerView: View>: View {
    @ObservedObject var vm: GameCardVM
    @State var color: Color
    @State var offset = CGSize.zero
    @State var hideView = false

    var isFrontUp: Bool
    
    @ViewBuilder var view: InnerView;

    var body: some View {
        if !hideView {
            ZStack {
                Rectangle()
                    .foregroundColor(color)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 4)
                
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        view
                        Spacer()
                    }
                    Spacer()
                    
                }
            }
            .onTapGesture {
                vm.flipCard()
            }
            .offset(x: offset.width, y: offset.height * 0.4)
            .rotationEffect(.degrees(Double(offset.width / 40)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
//                        print("OnChange")
                        offset = gesture.translation
                        withAnimation {
                            swipeColor(width: offset.width)
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            swipeColor(width: offset.width)
                            
                            swipeCard(width: offset.width)
                        }
                    }
            )
            .rotation3DEffect(
                Angle( degrees: !isFrontUp ? vm.frontDegree : vm.backDegree),
                axis: (x: 0, y: 1, z: 0.01)
            )
        }
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            hideView = true
            vm.update(isGuessed: false)
            
        case 150...500:
            offset = CGSize(width: 500, height: 0)
            hideView = true
            vm.update(isGuessed: true)
            
        default:
            offset = .zero
        }
    }
    
    func swipeColor(width: CGFloat) {
        switch width {
        case -500...(-130):
            color = .red
            
        case 130...500:
            color = .green
            
        default:
            color = vm.color
        }
    }
}

#Preview {
    GameCardView(cardModel: GameCard(), color: .orange)
}
