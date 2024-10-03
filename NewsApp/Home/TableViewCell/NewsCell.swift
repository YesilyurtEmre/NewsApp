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
    
    func configureCell(newsItem: NewsItem) {
        isFavorite = newsItem.isFavorite
        updateFavImage()
        newsImage.sd_setImage(with: URL(string: newsItem.image))
        tagTitleLabel.text = newsItem.source
        tagTitleLabel.textColor = .black
        tagTitleLabel.font = UIFont(name: "Montserrat-Light", size: 12)
        newsTitleLabel.text = newsItem.name
        newsTitleLabel.numberOfLines = 2
        newsTitleLabel.lineBreakMode = .byTruncatingTail
        newsTitleLabel.textColor = UIColor("#090816")
        newsTitleLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        newsDescLabel.numberOfLines = 3
        newsDescLabel.lineBreakMode = .byTruncatingTail
        newsDescLabel.text = newsItem.description
        newsDescLabel.textColor = UIColor("#090816")
        newsDescLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        selectionStyle = .none
    }
    
    func updateFavImage() {
        let imageName = isFavorite ? "Save" : "Save2"
        favImage.image = UIImage(named: imageName)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
