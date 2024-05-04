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
    @State private var showAddSectionView = false
    
    init() { UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var AddSection: some View {
        Button("Add Section") {
            showAddSectionView.toggle()
        }.sheet(
            isPresented: $showAddSectionView,
            onDismiss: { vm.refreshData()} ) {
                QuestionSelectionInputView(vm: .init(kind: .section) {
                    vm.refreshData()
                }).presentationDetents([.fraction(0.3)])
            }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.sections) { section in
                    QuestionSection(
                        vm: QuestionSectionVM(section: section) {
                            vm.refreshData()
                        }
                    )
                }
            }
            .navigationTitle("Questions")
            .navigationBarItems(
                leading: EditButton(),
                trailing: AddSection
            )
            .scrollContentBackground(.hidden)
            .background(ColorManager.backgroundGradient)
            .refreshable {
                vm.refreshData()
            }
        }
        .scrollContentBackground(.hidden)
        .accentColor(ColorManager.firstColor)
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
