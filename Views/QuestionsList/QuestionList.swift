//
//  QuestionList.swift
//  CardFlow
//
//  Created by Drumea Ion on 09/01/24.
//

import SwiftUI
import Foundation

struct QuestionList: View {
    @ObservedObject var vm = QuestionListVM()
    @Environment(\.editMode) var editMode
    @State private var showAddSectionView = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Questions")
                    .font(.title)
                    .foregroundColor(ColorManager.firstColor)
                Spacer()
                Button(editMode?.wrappedValue == .inactive ? "Edit" : "Done") {
                    editMode?.wrappedValue = editMode?.wrappedValue == .inactive ? .active : .inactive
                 }
                 .foregroundColor(ColorManager.firstColor)
            }
            .padding(.horizontal, 20)
            
            
            List {
                ForEach(vm.sections) { section in
                    QuestionSection(
                        vm: QuestionSectionVM(section: section) {
                            vm.refreshData()
                        }
                    )
                }
            }
            .listStyle(SidebarListStyle())
            .scrollContentBackground(.hidden)
            .refreshable {
                vm.refreshData()
            }
            
        }
        .background(ColorManager.backgroundGradient)
        .overlay(
            FloatingButton(icon: Image(systemName: "plus")) {
                showAddSectionView.toggle()
            }
        )
        .sheet(
            isPresented: $showAddSectionView ) {
                QuestionSelectionInputView(vm: .init(kind: .section) {
                    vm.refreshData()
                })
            }
    }
}

class QuestionListVM: ObservableObject {
    @Published var sections: [GameSection]
    
    init() {
        self.sections = DataManager.shared.sections()
    }
    
    func refreshData() {
        sections = DataManager.shared.sections()
    }
}

#Preview {
    QuestionList()
}
