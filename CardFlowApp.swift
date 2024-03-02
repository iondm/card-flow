//
//  Created by ion.dm on 26/06/23.
//

import SwiftUI

@main
struct CardFlowApp: App {
    @State private var selectedTab: Tab = .game
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    // Application start point.
    var body: some Scene {
        WindowGroup {
            ZStack {
                TabView(selection: $selectedTab,
                        content:  {
                    ForEach(Tab.allCases, id: \.rawValue) {tab in
                        switch tab {
                        case .game:
                            SessionView()
                                .tag(tab)
                        case .list:
                            QuestionList()
                                .tag(tab)
                        }
                        
                    }
                })
                
                VStack {
                    Spacer()
                    TabBard(selectedTab: $selectedTab)
                        
                }
                .padding(.bottom, 20)
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#Preview {
    VStack {
        QuestionList()
        TabBard(selectedTab: .constant(.game))
    }
}
