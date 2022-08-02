//
//  UIViewExtension.swift
//  TalTal
//
//  Created by Ruyha on 2022/07/25.
//

import Foundation
import UIKit

//MARK: xib파일을 사용하기위해 추가한 함수 변경시 오류가 생길 수 있습니다.
//출처: https://www.youtube.com/watch?v=-KTAgaX13s8
extension UIView {
    func loadViewFromNib(nibName: String) -> UIView?{
        let bundle = Bundle(for: type(of: self))
        let nib =  UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}


//MARK: UIColor를 헥사값으로 사용하기위한 extension
//출처: 서근 블로그에서 기본 소스를 받아 변형하였습니다.
//UIcolor(hex:"헥스컬러값")으로 사용가능합니다.
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
