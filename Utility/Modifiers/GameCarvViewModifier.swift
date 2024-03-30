//
//  Created by ion.dm on 26/06/23.
//

import SwiftUI

struct GameCarvViewModifier: ViewModifier {
    var color: Color = ColorManager.firstColor
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}

extension View {
    func gameCard(color: Color = ColorManager.firstColor) -> some View {
        modifier(GameCarvViewModifier(color: color))
    }
}
