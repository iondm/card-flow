//
//  GameCardService.swift
//  CardFlow
//
//  Created by Drumea Ion on 15/01/24.
//

import Foundation
import CoreData

// TODO: Use a Singleton.
// TODO: User CoreData instead of UserDefaults.
class DataManager {
    
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CardFlowData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createSection(name: String) -> GameSection {
        let section = GameSection(context: persistentContainer.viewContext)
        section.id = UUID()
        section.name = name
        save()
        return section
    }
    
    func createGameCard(question: String, answer: String, section: GameSection) -> GameCard {
        guard let order = section.cards?.count else {
            fatalError("Error on creating game card")
        }
        
        let gameCard = GameCard(context: persistentContainer.viewContext)
        gameCard.id = UUID()
        gameCard.answer = answer
        gameCard.question = question
        gameCard.order = Int32(order)
        gameCard.isGuessed = false
        section.addToCards(gameCard)
        save()
        return gameCard
    }
    
    func sections() -> [GameSection] {
        let request: NSFetchRequest<GameSection> = GameSection.fetchRequest()
        var fetchedSections: [GameSection] = []
        do {
            fetchedSections = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching sections \(error)")
        }
        return fetchedSections
    }
    
    func gameCards(section: GameSection) -> [GameCard] {
        let request: NSFetchRequest<GameCard> = GameCard.fetchRequest()
        request.predicate = NSPredicate(format: "section = %@", section)
        var fetchedcards: [GameCard] = []
        do {
            fetchedcards = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching gameCards \(error)")
        }
        return fetchedcards
    }
    
    func deleteGameCard(gameCard: GameCard) {
        let context = persistentContainer.viewContext
        context.delete(gameCard)
        save()
    }
    
    func deleteSection(section: GameSection) {
        let context = persistentContainer.viewContext
        context.delete(section)
        save()
    }
    
    func mockupSection() -> GameSection {
        let section = createSection(name: "Test")
        save()
        return section
    }
    
    func mockupCards(section: GameSection) -> [GameCard] {
        let card1 = createGameCard(question: "Q1", answer: "A1", section: section)
        let card2 = createGameCard(question: "Q1", answer: "A1", section: section)
        save()
        return [card1, card2]
    }
    
//    static func getSections() -> Dictionary<String, [OldGameCard]> {
//        guard let data = UserDefaults.standard.data(forKey: Keys.cards.rawValue) else {
//            return [:]
//        }
//        
//        let decoder = JSONDecoder()
//        
//        if let sections = try? decoder.decode(Dictionary<String, [OldGameCard]>.self, from: data) as Dictionary<String, [OldGameCard]> {
//            return sections
//        } else {
//            return [:]
//        }
//    }
    
//    static func save(sections: Dictionary<String, [OldGameCard]>) {
//        let encoder = JSONEncoder()
//        
//        if let data = try? encoder.encode(sections) {
//            UserDefaults.standard.set(data, forKey: Keys.cards.rawValue)
//        }
//    }
    
    
//    static func addSection(_ section: String) {
//        var sections = getSections()
//        sections[section] = []
//        
//        let encoder = JSONEncoder()
//        
//        if let data = try? encoder.encode(sections) {
//            UserDefaults.standard.set(data, forKey: Keys.cards.rawValue)
//        }
//    }
//    
//    static func remove(section: String) {
//        var sections = getSections()
//        sections.removeValue(forKey: section)
//        
//        let encoder = JSONEncoder()
//        
//        if let data = try? encoder.encode(sections) {
//            UserDefaults.standard.set(data, forKey: Keys.cards.rawValue)
//        }
//    }
    
//    static func addGameCard(_ gameCard: OldGameCard, to section: String) {
//        var sections = getSections()
//        
//        if sections[section] != nil {
//            sections[section]?.append(gameCard)
//            
//            let encoder = JSONEncoder()
//            
//            if let data = try? encoder.encode(sections) {
//                UserDefaults.standard.set(data, forKey: Keys.cards.rawValue)
//            }
//        }
//    }
}

private enum Keys: String {
    case cards
}
