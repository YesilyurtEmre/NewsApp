//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 12.09.2024.
//

import UIKit

class NewsDetailVC: UIViewController {
    var newsItem: NewsMockData?
    @IBOutlet weak var detailNewsImage: UIImageView!
    @IBOutlet weak var detailTagTitleLbl: UILabel!
    @IBOutlet weak var detailTitleLbl: UILabel!
    @IBOutlet weak var detailNewsDescLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = newsItem {
            detailNewsImage.image = UIImage(named: item.newsImage)
            detailTagTitleLbl.text = item.tagTitle
            detailTitleLbl.text = item.newsTitle
            detailNewsDescLbl.text = item.newsDesc
        }
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Google News"
        let customBackButton = UIBarButtonItem(image: UIImage(named: "Shape"), style: .plain, target: self, action: #selector(customBackButtonTapped))
        self.navigationItem.leftBarButtonItem = customBackButton
        customBackButton.tintColor = .black
    }
    
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
