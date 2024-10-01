//
//  NewsService.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 17.09.2024.
//

import UIKit

final class NewsService {
    
    private let headers = [
        "content-type": "application/json",
        "authorization": "apikey \(EndPoints.API_KEY)"
    ]
    
    func fetchNews(tag: String, completion: @escaping (Result<NewsModel, Error>) -> Void) {
        let url = URL(string: EndPoints.getNews(tag).stringValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            if let data = data {
                do {
                    let fetchedNews = try JSONDecoder().decode(NewsModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(fetchedNews))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            
            
        }
        task.resume()
    }
}

