//
//  NewsCell.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 12.09.2024.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var tagTitleLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescLabel: UILabel!
    @IBOutlet weak var favImage: UIImageView!
    
    var newsItem: NewsItem?
    var indexPath: IndexPath?
    var isFavorite: Bool = false
    var news: [NewsItem] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(favImageTapped))
        favImage.isUserInteractionEnabled = true
        favImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func favImageTapped() {
        guard let tableView = superview as? UITableView,
              let indexPath = tableView.indexPath(for: self) else { return }
        
        NotificationCenter.default.post(name: .favoriteButtonTapped, object: indexPath)
        
    }
    
    func updateFavImage() {
        let imageName = isFavorite ? "Save" : "Save2"
        favImage.image = UIImage(named: imageName)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
