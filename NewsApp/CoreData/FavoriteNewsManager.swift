//
//  FavoriteNewsManager.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 19.09.2024.
//

import CoreData
import UIKit

final class FavoriteNewsManager: CoreDataProtocol {
    
    static let shared = FavoriteNewsManager()
    typealias T = FavoriteNewsEntity

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    func saveData(data: FavoriteNewsEntity, completion: @escaping (Bool, CoreDataError) -> ()) {
        do {
            try self.context.save()
            completion(true, .noError)
        } catch {
            completion(false, .savingError)
        }
    }
    
    func fetchData(completion: @escaping ([FavoriteNewsEntity]?, CoreDataError) -> ()) {
        let fetchRequest = NSFetchRequest<FavoriteNewsEntity>(entityName: "FavoriteNewsEntity")
        let sortByCreatedAt = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sortByCreatedAt]
        do {
            let games = try context.fetch(fetchRequest)
            if games.count > 0 {
                completion(games, .noError)
            } else {
                completion(nil, .dataError)
            }
        } catch {
            completion(nil, .fetchingError)
        }
    }
    
    func deleteData(name: String, completion: @escaping (Bool, CoreDataError) -> ()) {
        let fetchRequest = NSFetchRequest<FavoriteNewsEntity>(entityName: "FavoriteNewsEntity")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        do {
            if let result = try context.fetch(fetchRequest).first {
                context.delete(result)
                try context.save()
                completion(true, .noError)
            }
        } catch {
            completion(false, .removingError)
        }
    }
    
    func deleteAllNews() {
        let request: NSFetchRequest<FavoriteNewsEntity> = FavoriteNewsEntity.fetchRequest()
        
        do {
            let newsItems = try context.fetch(request)
            for newsItem in newsItems {
                context.delete(newsItem)
            }
            try context.save()
            print("All news items deleted successfully!")
        } catch {
            print("Failed to delete news: \(error)")
        }
    }
}
