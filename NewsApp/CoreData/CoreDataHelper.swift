//
//  CoreDataHelper.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 19.09.2024.
//

import Foundation

extension Notification.Name {
    static let favoriteButtonTapped = Notification.Name("favImageTapped")
    static let favoritesUpdated = Notification.Name("favoritesUpdated")
}

enum CoreDataError: String, Error {
    case savingError   = "Data couldn't be saved"
    case removingError = "Data couldn't be removed"
    case fetchingError = "Data couldn't be fetched"
    case checkingError = "Data couldn't be checked"
    case dataError     = "Data couldn't be find"
    case noError
}

protocol CoreDataProtocol {
    associatedtype T
    func saveData(data: T, completion: @escaping (_ isSuccess: Bool, CoreDataError)->())
    func fetchData(completion: @escaping ([T]?, CoreDataError)->())
    func deleteData(name: String, completion: @escaping (_ isSuccess: Bool, CoreDataError)->())
}
