//
//  QuestionListVM.swift
//  CardFlow
//
//  Created by Drumea Ion on 24/01/24.
//

import Foundation

class QuestionListVM: ObservableObject {
    @Published var sections: Dictionary<String, [GameCard]>
    
    init() {
        sections = DataManager.getSections()
    }
    
    func delete(index: IndexSet) {
        sections["test"]?.remove(atOffsets: index)
        DataManager.save(sections: sections)
    }
    
    func move(originIndex: IndexSet, toOffset: Int) {
        sections["test"]?.move(fromOffsets: originIndex, toOffset: toOffset)
        DataManager.save(sections: sections)
    }
    
    func remove(section: String) {
        DataManager.remove(section: section)
    }
}
