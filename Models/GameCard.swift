//
//  GameCard.swift
//  CardFlow
//
//  Created by Drumea Ion on 15/01/24.
//

import Foundation

struct GameCard: Identifiable, Codable {
    var id = UUID()
    let question: String
    let answer: String
    
    init(_ question: String,_ answer: String) {
        self.question = question
        self.answer = answer
    }
    
    init() {
        // TODO: Remove, this is only for dev and test.
        question = "What is the capital of France?"
        answer = "Paris"
    }
}
