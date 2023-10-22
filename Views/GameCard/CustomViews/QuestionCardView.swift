//
// Created by ion.dm on 30/07/23.
//

import SwiftUI

struct QuestionCardView: View {
    private(set) var question: String
    private(set) var answer: String
    @State private(set) var userAnswer: String = ""
    //@FocusState private var answerFieldIsFocused: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Text(question)
            }
            
            VStack {
                Spacer()
                TextField("Answer", text: $userAnswer)
                //.focused($answerFieldIsFocused)
                    .onSubmit {print("yee")}
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                    .padding()
                Spacer()
            }
            
        }
    }
}

struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCardView(question: "What is the capital of France?", answer: "Paris")
    }
}
