//
//  UIViewExtension.swift
//  TalTal
//
//  Created by Ruyha on 2022/07/25.
//

import Foundation
import UIKit

extension UIView{
    func loadViewFromNib(nibName: String) -> UIView?{
        let bundle = Bundle(for: type(of: self))
        let nib =  UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}



extension UIColor {
    convenience init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
  }
}
