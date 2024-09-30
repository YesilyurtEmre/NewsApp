//
//  NewsModel.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 17.09.2024.
//

import Foundation

struct NewsModel: Codable {
    let success: Bool
    let result: [NewsItem]
}

struct NewsItem: Codable {
    var id = UUID()
    let key: String
    let url: String
    let description: String
    let image: String
    let name: String
    let source: String
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case key, url, description, image, name, source
    }
}
