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
        
    
    var news: [FavoriteNewsEntity] = []
    
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
        FavoriteNewsManager.shared.fetchData(completion: { news, error in
            if let news = news {
                self.news = news
            } else {
                self.news = []
            }
            self.favTableView.reloadData()
        })
    }
    
    @objc func reloadFavorites() {
        loadFavoriteNews()
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
        cell.indexPath = indexPath
        cell.newsTitleLabel.text = favoriteNews.name
        cell.newsDescLabel.text = favoriteNews.desc
        cell.newsDescLabel.numberOfLines = 3
        cell.tagTitleLabel.text = favoriteNews.source
        cell.newsImage.sd_setImage(with: URL(string: favoriteNews.image ?? ""))
        cell.isFavorite = true
        cell.updateFavImage()
        return cell
    }
}
