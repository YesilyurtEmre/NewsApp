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
    let key: String
    let url: String
    let description: String
    let image: String
    let name: String
    let source: String
}
