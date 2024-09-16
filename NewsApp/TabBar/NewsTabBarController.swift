//
//  NewsTabBarController.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 9.09.2024.
//

import Foundation
import UIKit

class NewsTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setupTabBarItems()
    }
    
    
    func setupTabBarItems() {
        guard let items = tabBar.items else {
            print("Tab bar items are nil.")
            return
        }
        
        let homeImage = UIImage(named: "Home2")?.withRenderingMode(.alwaysOriginal)
        let homeSelectedImage = UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal)
        items[0].image = homeImage
        items[0].selectedImage = homeSelectedImage
        
        
        let searchImage = UIImage(named: "Search2")?.withRenderingMode(.alwaysOriginal)
        let searchSelectedImage = UIImage(named: "Search")?.withRenderingMode(.alwaysOriginal)
        items[1].image = searchImage
        items[1].selectedImage = searchSelectedImage
        
        
        
        let saveImage = UIImage(named: "Save2")?.withRenderingMode(.alwaysOriginal)
        let saveSelectedImage = UIImage(named: "Save")?.withRenderingMode(.alwaysOriginal)
        items[2].image = saveImage
        items[2].selectedImage = saveSelectedImage
        
        
    }
}
