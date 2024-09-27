//
//  FavoriteNewsManager.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 19.09.2024.
//

import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    func getNews() -> [FavoriteNewsEntity]
    func saveNews(name: String, source: String, desc: String, image: String, key: String, url: String, id: UUID)
    func deleteNews(id: UUID)
    func isFavorite(id: UUID) -> Bool
}

final class FavoriteNewsManager: CoreDataManagerProtocol {
    
    private let persistentContainer: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    static let shared = FavoriteNewsManager()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "NewsModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        self.context = persistentContainer.viewContext
    }
    
    func getNews() -> [FavoriteNewsEntity] {
        let fetchRequest: NSFetchRequest<FavoriteNewsEntity> = FavoriteNewsEntity.fetchRequest()
        let sortByCreatedAt = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sortByCreatedAt]
        do {
            let news = try persistentContainer.viewContext.fetch(fetchRequest)
            print("Fetched news: \(news)")
            return news
        } catch let fetchError as NSError {
            print("Failed to fetch news: \(fetchError), \(fetchError.userInfo)")
            return []
        }
    }
    
    func saveNews(name: String, source: String, desc: String, image: String, key: String, url: String, id: UUID) {
        //        self.context.perform { [weak self] in
        //            guard let self else { return }
        let context = persistentContainer.viewContext
        let entity = FavoriteNewsEntity(context: context)
        entity.desc = desc
        entity.name = name
        entity.source = source
        entity.key = key
        entity.url = url
        entity.image = image
        entity.createdAt = Date()
        entity.id = id
        do {
            try context.save()
            print("News saved successfully!")
        } catch {
            print("Failed to save news: \(error)")
        }
        //        }
    }
    
    func deleteNews(id: UUID) {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<FavoriteNewsEntity> = FavoriteNewsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let newsItems = try context.fetch(request)
            for newsItem in newsItems {
                context.delete(newsItem)
            }
            try context.save()
        } catch {
            print("Failed to delete news: \(error)")
        }
    }
    
    func isFavorite(id: UUID) -> Bool {
        let context = persistentContainer.viewContext
        print("id---\(id)")
        let request: NSFetchRequest<FavoriteNewsEntity> = FavoriteNewsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let count = try context.count(for: request)
            print("count---\(count)")
            return count > 0
        } catch {
            print("Failed to check if news is favorite: \(error)")
            return false
        }
    }
    
    func deleteAllNews() {
        let fetchRequest: NSFetchRequest<FavoriteNewsEntity> = FavoriteNewsEntity.fetchRequest()
        
        do {
            let newsItems = try context.fetch(fetchRequest)
            for newsItem in newsItems {
                context.delete(newsItem)
            }
            try context.save()
            print("All news items deleted successfully!")
        } catch {
            print("Failed to delete news: \(error)")
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
}
