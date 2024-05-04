//
//  FloatingButton.swift
//  CardFlow
//
//  Created by Drumea Ion on 04/05/24.
//

import SwiftUI

struct FloatingButton: View {
    let icon: Image
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(ColorManager.BelizeHole)
                .shadow(radius: 4)
            icon
                .foregroundColor(.white)
        }
        .frame(width: 40, height: 40)
        .position(x: UIScreen.main.bounds.width - 60, y: UIScreen.main.bounds.height - 150)
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    FloatingButton(icon: Image(systemName: "plus"), action: {})
}
