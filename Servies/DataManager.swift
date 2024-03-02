//
//  GameCardService.swift
//  CardFlow
//
//  Created by Drumea Ion on 15/01/24.
//

import Foundation

// TODO: Use a Singleton.
// TODO: User CoreData instead of UserDefaults.
class DataManager {
    static func getCards(section: String) -> [GameCard] {
        guard let data = UserDefaults.standard.data(forKey: Keys.cards.rawValue) else {
            return []
        }
        
        let decoder = JSONDecoder()
        
        if let sections = try? decoder.decode(Dictionary<String, [GameCard]>.self, from: data) as Dictionary<String, [GameCard]> {
            return sections[section] ?? []
        } else {
            return []
        }
    }
    
    static func printCards(_ sections: Dictionary<String, [GameCard]>) {
        for (section, gameCards) in sections {
            print("\(section) -> \(gameCards)")
        }
    }
        
    static func getSections() -> Dictionary<String, [GameCard]> {
        guard let data = UserDefaults.standard.data(forKey: Keys.cards.rawValue) else {
            return [:]
        }
        
        let decoder = JSONDecoder()
        
        if let sections = try? decoder.decode(Dictionary<String, [GameCard]>.self, from: data) as Dictionary<String, [GameCard]> {
            printCards(sections)
            return sections
        } else {
            return [:]
        }
    }
    
    static func save(sections: Dictionary<String, [GameCard]>) {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(sections) {
            UserDefaults.standard.set(data, forKey: Keys.cards.rawValue)
        }
    }
    
    
    static func addSection(_ section: String) {
        var sections = getSections()
        sections[section] = []
        
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(sections) {
            UserDefaults.standard.set(data, forKey: Keys.cards.rawValue)
        }
    }
    
    static func remove(section: String) {
        var sections = getSections()
        sections.removeValue(forKey: section)
        
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(sections) {
            UserDefaults.standard.set(data, forKey: Keys.cards.rawValue)
        }
    }
    
    static func addGameCard(_ gameCard: GameCard, to section: String) {
        var sections = getSections()
        
        if sections[section] != nil {
            sections[section]?.append(gameCard)

            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(sections) {
                UserDefaults.standard.set(data, forKey: Keys.cards.rawValue)
            }
        }
    }
}

private enum Keys: String {
    case cards
}
