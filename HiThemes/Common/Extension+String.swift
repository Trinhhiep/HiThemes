//
//  Extension+String.swift
//  HiThemes
//
//  Created by Trinh Quang Hiep on 14/11/2022.
//

import Foundation
import UIKit
extension String{
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
