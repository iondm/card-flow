//
//  TransactionViewModifier.swift
//  CardFlow
//
//  Created by Drumea Ion on 18/01/24.
//

import SwiftUI
import Foundation

struct TransactionLeadingInViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(30)
            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .move(edge: .top)),
                removal: .move(edge: .leading)
            ))
    }
}

struct TransactionTrailingOutViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(30)
            .transition(.asymmetric(
                insertion: .move(edge: .leading),
                removal: .move(edge: .trailing).combined(with: .move(edge: .top))
            ))
    }
}


extension View {
    func transactionLeadingIn() -> some View {
        modifier(TransactionLeadingInViewModifier())
    }
    
    func transactionTrailingOut() -> some View {
        modifier(TransactionTrailingOutViewModifier())
    }
}
