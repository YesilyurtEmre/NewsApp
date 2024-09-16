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
            detailTagTitleLbl.font = UIFont(name: "Montserrat-Light", size: 12)
            detailTagTitleLbl.textColor = UIColor("#000000")
            detailTitleLbl.text = item.newsTitle
            detailTitleLbl.font = UIFont(name: "Montserrat-Medium", size: 16)
            detailTitleLbl.textColor = UIColor("#090816")
            detailNewsDescLbl.text = item.newsDesc
            detailNewsDescLbl.font = UIFont(name: "Montserrat-Regular", size: 14)
            detailNewsDescLbl.textColor = UIColor("#090816")
        }
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Google News"
        let customBackButton = UIBarButtonItem(image: UIImage(named: "Shape"), style: .plain, target: self, action: #selector(customBackButtonTapped))
        self.navigationItem.leftBarButtonItem = customBackButton
        customBackButton.tintColor = .black
    }
    
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: false)
    }
}
