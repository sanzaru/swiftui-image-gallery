//
//  FavoritesService.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 31.10.20.
//

import SwiftUI
import CoreData

struct PicsumFavoriteService {
    static let shared = PicsumFavoriteService()
    
    private let entityName = "PicsumFavorite"
    private let viewContext = PersistenceController.shared.container.viewContext
    private var favorites: [String] = []
    
    init() {
        let request = NSFetchRequest<PicsumFavorite>(entityName: entityName)
        do {
            let result = try viewContext.fetch(request)
            favorites = result.compactMap { $0.id }
        } catch {
            fatalError("Error fetching favorites")
        }
    }
    
    func isFavorite(by id: String) -> Bool {
        return favorites.contains(id)
    }
    
    func delete(by id: String) {
        do {
            let items = try fetchItem(by: id)
            if items.count > 0 {
                for item in items {
                    viewContext.delete(item)
                }
                
                try viewContext.save()
            }
        } catch {
            let nsError = error as NSError
            fatalError("Error deleting favorite: \(nsError), \(nsError.userInfo)")
        }
    }
    
    func add(by id: String) {
        do {
            if !exists(by: id) {
                let item = PicsumFavorite(context: viewContext)
                item.id = id
                
                try viewContext.save()
            }
        } catch {
            let nsError = error as NSError
            fatalError("Error adding favorite \(nsError), \(nsError.userInfo)")
        }
    }
    
    // MARK: - Private methods
    
    private func exists(by id: String) -> Bool {
        do {
            let fetchResult = try fetchItem(by: id)
            return fetchResult.count > 0
        } catch {
            return false
        }
    }
    
    private func fetchItem(by id: String) throws ->  [PicsumFavorite] {
        let fetchRequest: NSFetchRequest<PicsumFavorite> = PicsumFavorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        return try viewContext.fetch(fetchRequest)
    }
}
