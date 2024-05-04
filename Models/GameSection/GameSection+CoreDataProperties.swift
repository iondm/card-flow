//
//  GameSection+CoreDataProperties.swift
//  CardFlow
//
//  Created by Drumea Ion on 03/05/24.
//
//

import Foundation
import CoreData


extension GameSection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameSection> {
        return NSFetchRequest<GameSection>(entityName: "GameSection")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var cards: NSSet?

}

// MARK: Generated accessors for cards
extension GameSection {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: GameCard)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: GameCard)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}

extension GameSection : Identifiable {

}
