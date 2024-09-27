//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 9.09.2024.
//

import UIKit


class HomeViewController: BaseVC {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var newsTableView: UITableView!
    
    var selectedCategoryIndex: IndexPath?
    
    let newsService = NewsService()
    
    let mockData: [NewsMockData] = [
        NewsMockData(newsImage: "NewsImage1", tagTitle: "WEBTEKNO", newsTitle: "2023 Nisan ayında en çok satan sedan otomobiller!", newsDesc: "Wise hesabınızda farklı para birimleri dahil olmak üzere para bulunduramayacaksınız. TransferGo.Wise hesabınızda farklı para birimleri dahil olmak üzere para bulunduramayacaksınız. TransferGoWise hesabınızda farklı para birimleri dahil olmak üzere para bulunduramayacaksınız. TransferGo. Wise hesabınızda farklı para birimleri dahil olmak üzere para bulunduramayacaksınız. TransferGo.Wise hesabınızda farklı para birimleri dahil olmak üzere para bulunduramayacaksınız. TransferGo.Wise hesabınızda farklı para birimleri dahil olmak üzere para bulunduramayacaksınız. TransferGo..."),
        NewsMockData(newsImage: "NewsImage2", tagTitle: "BLOOMBERG HT", newsTitle: "Wise, Türkiye'deki kullanıcılara para transferi kısıtlaması getirdi; TransferGo ise tüm transferleri durdurdu", newsDesc: "Wise hesabınızda farklı para birimleri dahil olmak üzere para bulunduramayacaksınız. TransferGo.Wise hesabınızda farklı para birimleri dahil olmak üzere para bulunduramayacaksınız. TransferGoWise hesabınızda farklı para birimleri dahil olmak üzere para bulunduramayacaksınız. TransferGo. Wise hesabınızda farklı para birimleri dahil olmak üzere para bulunduramayacaksınız. TransferGo.Wise hesabınızda farklı para birimleri dahil olmak üzere para bulunduramayacaksınız. TransferGo.Wise hesabınızda farklı para birimleri dahil olmak üzere para bulunduramayacaksınız. TransferGo...")
    ]
    
    var news: [NewsItem] = []
    
    var tag: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleFavoriteButtonTapped(notification:)),
            name: .favoriteButtonTapped,
            object: nil
        )
        
        configureCollectionView()
        configureTableView()
        titleLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        titleLabel.textColor = UIColor("#090816")
        tag = Categories.allCases[selectedCategoryIndex?.row ?? 0].tag
        indicator.startAnimating()
        fetcNews(tag: tag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func handleFavoriteButtonTapped(notification: Notification) {
        guard let indexPath = notification.object as? IndexPath else {
            print("Notification içinde indexPath yok")
            return
        }
        
        let newsItem = news[indexPath.row]
        print("Selected News Item: \(newsItem)")
        print("newsItem.id-----\(newsItem.id)")
        let isFavorite = FavoriteNewsManager.shared.isFavorite(id: newsItem.id)
        print("bura isFavorite--\(isFavorite)")
        
//        if isFavorite {
//            FavoriteNewsManager.shared.deleteNews(id: newsItem.id)
//        } else {
//            FavoriteNewsManager.shared.saveNews(
//                name: newsItem.name,
//                source: newsItem.source,
//                desc: newsItem.description,
//                image: newsItem.image,
//                key: newsItem.key,
//                url: newsItem.url,
//                id: newsItem.id
//            )
//        }
////        newsTableView.reloadData()
//        if let cell = newsTableView.cellForRow(at: indexPath) as? NewsCell {
//            cell.isFavorite = !isFavorite
//            cell.updateFavImage()
//        }
//        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
    }
    
    
    private func fetcNews(tag: String) {
        indicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            self.newsService.fetchNews(tag: tag) { response in
                switch response {
                case .success(let response):
                    self.news = response.result
                    self.indicator.stopAnimating()
                    self.newsTableView.reloadData()
                case .failure(let failure):
                    self.indicator.stopAnimating()
                    print("failure: \(failure)")
                }
            }
        }
    }
    
    private func configureTableView() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        selectedCategoryIndex = IndexPath(item: 0, section: 0)
        categoryCollectionView.selectItem(at: selectedCategoryIndex, animated: false, scrollPosition: [])
        updateCellSelection()
        
    }
    
    private func configureCollectionView() {
        let nib = UINib(nibName: "CategoryCell", bundle: nil)
        categoryCollectionView.register(nib, forCellWithReuseIdentifier: "CategoryCell")
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.allowsSelection = true
        
        let design = UICollectionViewFlowLayout()
        design.scrollDirection = .horizontal
        
        design.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Categories.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = Categories.allCases[indexPath.row]
        if indexPath == selectedCategoryIndex {
            cell.categoryCellView.backgroundColor = .white
            cell.categoryLabel.text = category.title
            cell.categoryLabel.textColor = .black
        } else {
            cell.categoryCellView.backgroundColor = UIColor("#ECECEC")
            cell.categoryLabel.text = category.title
            cell.categoryLabel.textColor = UIColor("#9C9C9C")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryIndex = indexPath
        tag = Categories.allCases[selectedCategoryIndex?.row ?? 0].tag
        fetcNews(tag: tag)
        updateCellSelection()
    }
    
    func updateCellSelection() {
        categoryCollectionView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let newsItem = news[indexPath.row]
        newsService.setImageToImageView(imageURL: newsItem.image) { image in
            if let image = image {
                cell.newsImage.image = image
            } else {
                print("Failed to load image")
            }
        }
        cell.indexPath = indexPath
        cell.tagTitleLabel.text = newsItem.source
        cell.tagTitleLabel.textColor = .black
        cell.tagTitleLabel.font = UIFont(name: "Montserrat-Light", size: 12)
        cell.newsTitleLabel.text = newsItem.name
        cell.newsTitleLabel.numberOfLines = 2
        cell.newsTitleLabel.lineBreakMode = .byTruncatingTail
        cell.newsTitleLabel.textColor = UIColor("#090816")
        cell.newsTitleLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        cell.newsDescLabel.numberOfLines = 3
        cell.newsDescLabel.lineBreakMode = .byTruncatingTail
        cell.newsDescLabel.text = newsItem.description
        cell.newsDescLabel.textColor = UIColor("#090816")
        cell.newsDescLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        cell.selectionStyle = .none
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toNewsDetail", sender: news[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? NewsDetailVC,
           let data = sender as? NewsItem {
            detailVC.news = data
        }
    }
}




