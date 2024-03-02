//
//  QuestionListVM.swift
//  CardFlow
//
//  Created by Drumea Ion on 24/01/24.
//

import Foundation

class QuestionListVM: ObservableObject {
    @Published var sections: Dictionary<String, [GameCard]> = [:]
    
    init() {
        updateData()
    }
    
    func delete(index: IndexSet, section: String) {
        sections[section]?.remove(atOffsets: index)
        DataManager.save(sections: sections)
        waitAndUpdate()
    }
    
    func move(originIndex: IndexSet, toOffset: Int, section: String) {
        sections[section]?.move(fromOffsets: originIndex, toOffset: toOffset)
        DataManager.save(sections: sections)
        waitAndUpdate()
    }
    
    func remove(section: String) {
        DataManager.remove(section: section)
        waitAndUpdate()
    }
    
    func waitAndUpdate() {
        #warning("Do not use sleep, change UserDefaults with CoreData")
        Task {
            try? await Task.sleep(nanoseconds: UInt64(0.2 * Double(NSEC_PER_SEC)))
            DispatchQueue.main.async {
                self.updateData()
            }
        }
    }
    
    func updateData() {
        print("init QuestionListVM")
        sections = DataManager.getSections()
        print("sections: ")
        print(sections)
    }
}
