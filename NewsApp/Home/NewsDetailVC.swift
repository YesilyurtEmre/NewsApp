//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 12.09.2024.
//

import UIKit

class NewsDetailVC: BaseVC {
    
    let newsService = NewsService()
    var newsItem: NewsMockData?
    var news: NewsItem?
    @IBOutlet weak var detailNewsImage: UIImageView!
    @IBOutlet weak var detailTagTitleLbl: UILabel!
    @IBOutlet weak var detailTitleLbl: UILabel!
    @IBOutlet weak var detailNewsDescLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let newsItem = news {
            
            setImageToImageView(imageURL: newsItem.image) { [weak self] image in
                if let image = image {
                    self?.detailNewsImage.image = image
                } else {
                    self?.detailNewsImage.image = UIImage(named: "placeholder")
                }
            }
            detailTagTitleLbl.text = newsItem.source
            detailTagTitleLbl.font = UIFont(name: "Montserrat-Light", size: 12)
            detailTagTitleLbl.textColor = UIColor("#000000")
            detailTitleLbl.text = newsItem.name
            detailTitleLbl.font = UIFont(name: "Montserrat-Medium", size: 16)
            detailTitleLbl.textColor = UIColor("#090816")
            detailNewsDescLbl.text = newsItem.description
            detailNewsDescLbl.font = UIFont(name: "Montserrat-Regular", size: 14)
            detailNewsDescLbl.textColor = UIColor("#090816")
        }
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Google News"
        let customBackButton = UIBarButtonItem(image: UIImage(named: "Shape"), style: .plain, target: self, action: #selector(customBackButtonTapped))
        self.navigationItem.leftBarButtonItem = customBackButton
        customBackButton.tintColor = .black
    }
    
    func setImageToImageView(imageURL: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageURL) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("No data or invalid image format")
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: false)
    }
}
