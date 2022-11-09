//
//  Extension+UIView.swift
//  MiniAppCore
//
//  Created by Trinh Quang Hiep on 20/09/2022.
//

import Foundation
import UIKit
extension UIView{
    func roundCorner(borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.cornerRadius  = cornerRadius
        self.layer.masksToBounds = true
        self.layer.borderWidth   = borderWidth
        self.layer.borderColor   = borderColor.cgColor
    }
}
