//
//  Created by ion.dm on 26/06/23.
//

import SwiftUI

@main
struct CardFlowApp: App {
    var body: some Scene {
        WindowGroup {
            QuestionList()
        }
    }
}

#Preview {
    VStack {
        QuestionList()
    }
}
