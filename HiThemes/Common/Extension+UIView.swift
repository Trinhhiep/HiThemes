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
    
    enum TransitionAnimationPopupType{
        case ShowBottomTop
        case HideBottomTop
        
        case HideLeftToRight
        case ShowRightToLeft
        
    }
    func showHidePopup(background : UIView, animationType : TransitionAnimationPopupType){
        UIView.animate(withDuration: 0.5, delay: 0,
                       options: [.curveEaseInOut, .transitionCrossDissolve], animations: {
            switch animationType {
            case .ShowBottomTop:
                self.frame.origin.y -= UIScreen.main.bounds.height
                background.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            case .HideBottomTop:
                self.frame.origin.y += UIScreen.main.bounds.height
                background.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            case .ShowRightToLeft:
                self.frame.origin.x -= UIScreen.main.bounds.width
                background.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            case .HideLeftToRight:
                self.frame.origin.x += UIScreen.main.bounds.width
                background.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                
            }
        })
    }
}
