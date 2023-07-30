//
//  Created by ion.dm on 27/06/23.
//

import Foundation
import SwiftUI

extension View {
    func gameCard(color: Color = Color.white) -> some View {
        
        modifier(GameCarvViewModifier(color: color))
    }
}
