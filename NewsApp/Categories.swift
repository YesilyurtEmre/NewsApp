//
//  Categories.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 11.09.2024.
//

import Foundation

enum Categories: Int, CaseIterable {
    case general
    case sport
    case economy
    case technology
    
    var title: String {
        switch self {
        case .general:
            return "General"
        case .sport:
            return "Sport"
        case .economy:
            return "Economy"
        case .technology:
            return "Technology"
        }
    }
    
    var tag: String {
        switch self {
        case .general:
            return "genel"
        case .sport:
            return "spor"
        case .economy:
            return "ekonomi"
        case .technology:
            return "teknoloji"
        }
    }
}
