//
//  GameCard+CoreDataProperties.swift
//  CardFlow
//
//  Created by Drumea Ion on 03/05/24.
//
//

import Foundation
import CoreData


extension GameCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameCard> {
        return NSFetchRequest<GameCard>(entityName: "GameCard")
    }

    @NSManaged public var answer: String?
    @NSManaged public var id: UUID?
    @NSManaged public var question: String?
    @NSManaged public var order: Int32
    @NSManaged public var section: GameSection?

}

extension GameCard : Identifiable {

}
