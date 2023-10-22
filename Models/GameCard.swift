//
//  Created by ion.dm on 05/07/23.
//

import Foundation
import SwiftUI

struct GameCard {
    var backgroundColor = Color.white
    var question: String
    var answer: String
    var type: String
    var id : String
    
    init() {
        // TODO: Remove, this is only for dev and test.
        backgroundColor = ColorManager.Orange
        question = "What is the capital of France?"
        answer = "Paris"
        type = "Geography"
        id = "1"
    }
}
