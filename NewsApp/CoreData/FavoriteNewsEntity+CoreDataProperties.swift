//
//  FavoriteNewsEntity+CoreDataProperties.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 25.09.2024.
//
//

import Foundation
import CoreData


extension FavoriteNewsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteNewsEntity> {
        return NSFetchRequest<FavoriteNewsEntity>(entityName: "FavoriteNewsEntity")
    }

    @NSManaged public var key: String?
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var source: String?
    @NSManaged public var image: String?
    @NSManaged public var url: String?
    @NSManaged public var id: UUID?
    @NSManaged public var createdAt: Date?

}

extension FavoriteNewsEntity : Identifiable {

}
