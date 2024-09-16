//
//  Color+Ext.swift
//  NewsApp
//
//  Created by Emre Yeşilyurt on 12.09.2024.
//

import UIKit

extension UIColor {
    convenience init(_ hex: String) {
        var hexFormatted: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UILabel {
    func setCustomFont(fontName: String, size: CGFloat) {
        self.font = UIFont(name: "Montserrat-Bold", size: size)
        self.font = UIFont(name: "Montserrat-Light", size: size)
        self.font = UIFont(name: "Montserrat-Medium", size: size)
        self.font = UIFont(name: "Montserrat-Regular", size: size)
        self.font = UIFont(name: "Montserrat-Thin", size: size)
        
    }
}
