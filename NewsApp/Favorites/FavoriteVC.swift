//
//  FavoriteVC.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 19.09.2024.
//

import UIKit

final class FavoriteVC: UIViewController {
    @IBOutlet weak var favTitleLbl: UILabel!
    @IBOutlet weak var favTableView: UITableView!
    
    let newsService = NewsService()
    
    
    var news: [FavoriteNewsEntity] = []
    var favoriteNews: [NewsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTitleLbl.text = "Favorites"
        favTitleLbl.font = UIFont(name: "Montserrat-Medium", size: 16)
        favTitleLbl.textColor = UIColor("#090816")
        
        configureTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFavorites), name: .favoritesUpdated, object: nil)        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadFavoriteNews()
    }
    
    private func loadFavoriteNews() {
        news = FavoriteNewsManager.shared.getNews()
        self.favTableView.reloadData()
    }
    
    @objc func reloadFavorites() {
        news = FavoriteNewsManager.shared.getNews()
        favTableView.reloadData()
    }
    
    private func configureTableView() {
        favTableView.dataSource = self
        favTableView.delegate = self
        favTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }
}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let favoriteNews = news[indexPath.row]
        
        cell.newsTitleLabel.text = favoriteNews.name
        cell.newsDescLabel.text = favoriteNews.desc
        cell.tagTitleLabel.text = favoriteNews.source
        //        cell.newsImage.image = UIImage(named: "placeholderImage")
        
        newsService.setImageToImageView(imageURL: favoriteNews.image ?? "") { image in
            DispatchQueue.main.async {
                cell.newsImage.image = image
            }
        }
        
        let isFavorite = FavoriteNewsManager.shared.isFavorite(id: favoriteNews.id!)// force unwrapped id
        cell.isFavorite = isFavorite
        cell.updateFavImage()
        //        newsService.setImageToImageView(imageURL: favoriteNews.image ?? "") { image in
        //
        //            if let image = image {
        //                cell.newsImage.image = image
        //            }else {
        //                print("Failed to load image")
        //            }
        //        }
        return cell
    }
}
