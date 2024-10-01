//
//  SearchVC.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 30.09.2024.
//

import UIKit

class SearchVC: UIViewController {
    @IBOutlet weak var searchLbl: UILabel!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBarView: UIView!
    
    let newsService = NewsService()
    var news: [FavoriteNewsEntity] = []
    var filteredNews: [NewsItem] = []
    var searchedNews: [NewsItem] = []
    
    let textField = UITextField()
    let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchLbl.font = UIFont(name: "Montserrat-Medium", size: 16)
        searchLbl.textColor = UIColor("#090816")
        configureTableView()
        setupSearchBarView()
        fetchInitialNews()
    }
    
    private func configureTableView() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }
    
    private func setupSearchBarView() {
        textField.placeholder = "Ara"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 17.5
        textField.isUserInteractionEnabled = true
        textField.keyboardType = .default
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 35))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        searchBarView.addSubview(textField)
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: searchBarView.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor, constant: -15),
            textField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        searchIcon.tintColor = .lightGray
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.contentMode = .scaleAspectFit
        searchBarView.addSubview(searchIcon)
        
        NSLayoutConstraint.activate([
            searchIcon.centerYAnchor.constraint(equalTo: searchBarView.centerYAnchor),
            searchIcon.trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor, constant: -25),
            searchIcon.widthAnchor.constraint(equalToConstant: 25),
            searchIcon.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchIconTapped))
        searchIcon.isUserInteractionEnabled = true
        searchIcon.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let searchText = textField.text, !searchText.isEmpty {
            searchNews(searchText: searchText)
            searchIcon.image = UIImage(systemName: "xmark.circle")
            isSearching = true
        } else {
            updateTableView()
            searchIcon.image = UIImage(systemName: "magnifyingglass")
            isSearching = false
        }
    }
    
    @objc func searchIconTapped() {
        if isSearching {
            textField.text = ""
            updateTableView()
            searchIcon.image = UIImage(systemName: "magnifyingglass")
            isSearching = false
        } else {
            isSearching = true
        }
    }
    
    private func updateTableView() {
        filteredNews.removeAll()
        searchTableView.reloadData()
    }
    
    private func fetchInitialNews() {
        newsService.fetchNews(tag: "general") { result in
            switch result {
            case .success(let newsModel):
                self.searchedNews = newsModel.result
            case .failure(let error):
                print("Fetch error: \(error)")
            }
        }
    }
    
    func searchNews(searchText: String) {
        if searchText.isEmpty {
            filteredNews = searchedNews
        } else {
            filteredNews = searchedNews.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        searchTableView.reloadData()
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let searchNews = filteredNews[indexPath.row]
        cell.newsTitleLabel.text = searchNews.name
        cell.newsDescLabel.text = searchNews.description
        cell.newsDescLabel.numberOfLines = 3
        cell.tagTitleLabel.text = searchNews.source
        
        newsService.setImageToImageView(imageURL: searchNews.image) { image in
            DispatchQueue.main.async {
                cell.newsImage.image = image
            }
        }
        
        return cell
    }
    
    
}
