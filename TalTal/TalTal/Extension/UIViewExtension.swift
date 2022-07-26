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
