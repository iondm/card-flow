//
//  Created by ion.dm on 26/06/23.
//

import SwiftUI

// It is how we can declare the method of a view as .cardBackground()
struct GameCarvViewModifier: ViewModifier {
    var color: Color = Color.white
    
    func body(content: Content) -> some View {
        content
            .background(color)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}


struct colorScaleViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var startColor: Color
    var endColor: Color
    var textColor: Color

    func body(content: Content) -> some View {
        content
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
//            .padding(3)
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: roundedCornes)
                        .stroke(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.5))
            .font(.custom("Open Sans", size: 18))

//            .shadow(radius: 10)
    }
}
