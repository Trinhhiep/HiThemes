//
//  CustomDropdownManager.swift
//  HiThemes
//
//  Created by Trinh Quang Hiep on 14/11/2022.
//

import Foundation
import UIKit
class DropDownManager: NSObject {
    static let shared = DropDownManager()
    private override init() {}
    private var presentingView: UIView?
    
    func showDropView(sender : UIButton,data : [DropViewModel],onSelect: ((Int) -> Void)?) {
        presentingView?.removeFromSuperview()
        var arrWidth = [CGFloat]()
        for i in 0..<data.count {
            arrWidth.append(data[i].title?.widthOfString(usingFont: UIFont.systemFont(ofSize: 15)) ?? CGFloat())
        }
        let witdh = arrWidth.max() ?? CGFloat()
        let widthofView = witdh + 50
//        print("witdh là : \(arrWidth)")
//        print("witdh là : \(widthofView)")

        guard let window = UIApplication.shared.keyWindow else { return }
        let width = (sender.frame.width)/2
        let height = sender.sizeThatFits(.zero).height
        let x = sender.superview?.convert(sender.frame.origin, to: nil).x ?? CGFloat()
        let y = sender.superview?.convert(sender.frame.origin, to: nil).y ?? CGFloat()
        let creatHeight = height + y
        
        let dropDownViewContainer = DialogContainerView(frame: window.bounds)
        var vDescription = DropDownView()
        if  x < 75 {
            let creatHeight = height + y
            vDescription = DropDownView(frame: CGRect(x: x, y: creatHeight, width: widthofView, height: CGFloat(37 * (data.count))))
        } else if 75 <= x && x <= 250{
            vDescription = DropDownView(frame: CGRect(x: x, y: creatHeight, width: widthofView, height: CGFloat(37 * (data.count))))
            vDescription.center.x = sender.center.x
        } else {
            vDescription = DropDownView(frame: CGRect(x: x + width - widthofView, y: creatHeight + 5, width: widthofView, height: CGFloat(37 * (data.count))))
        }
        vDescription.onSelect = {
            onSelect?($0)
            dropDownViewContainer.removeFromSuperview()
        }
        vDescription.arrData = data
        dropDownViewContainer.addSubview(vDescription)
        window.addSubview(dropDownViewContainer)
        
        self.presentingView = dropDownViewContainer
    }
}
