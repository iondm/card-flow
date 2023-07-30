//
//  Created by ion.dm on 26/06/23.
//

import SwiftUI

// It is how we can declare the method of a view as .cardBackground()
struct GameCarvViewModifier: ViewModifier {
    var color: Color = Color.white
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity,maxHeight: UIScreen.screenHeight * 6)
            .background(color)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
            .padding(.all, 30)
    }
}
