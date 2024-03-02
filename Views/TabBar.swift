//
//  TabBar.swift
//  CardFlow
//
//  Created by Drumea Ion on 15/01/24.
//

import Foundation
import SwiftUI

enum Tab: String, CaseIterable {
    case game = "menucard"
    case list = "list.dash"
}

struct TabBard: View {
    @Binding var selectedTab: Tab
    
    private var tabColor: Color {
        switch selectedTab {
        case .game:
            return .red
        case .list:
            return .blue
        }
    }
    
    private var selectedIamge: String {
        switch selectedTab {
        case .game:
            return "menucard.fill"
        case .list:
            return "list.dash"
        }
    }
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Spacer()
                Image(systemName: selectedTab == tab ? selectedIamge : tab.rawValue)
                    .scaleEffect(
                        selectedTab == tab ? 1.20 : 1.00
                    )
                    .foregroundColor(selectedTab == tab ? tabColor : .gray)
                    .font(.system(size: 22))
                    .onTapGesture { withAnimation(.easeIn(duration: 0.1), {
                        selectedTab = tab
                    })}
                
                Spacer()
                
            }
        }
        .frame(width: nil, height: 50)
        .background(.thinMaterial)
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    TabBard(selectedTab: .constant(.game))
}
