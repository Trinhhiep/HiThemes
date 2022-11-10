//
//  PopupManager.swift
//  HiThemes
//
//  Created by Trinh Quang Hiep on 10/11/2022.
//

import Foundation
import UIKit
public class PopupManager{
    public static var share = PopupManager()
    private init(){}
    public func presentTest(vc : UIViewController){
        let title = "Test Title Popup"
        let content = NSMutableAttributedString(string: "Cảm ơn Quý khách đã đánh giá Kỹ thuật viên của FPT Telecom!")
        let cancel = "Cancel"
        let confirm = "Confirm"
        
        let typeConfirm = PopupType.confirm(title: title, content: content,
                                     titleLeftBtn: cancel,
                                     titleRightBtn: cancel) {
            
        } actionRightBtn: {
            
        }
        
        let typeAlert = PopupType.alert(title: title, content: content, titleRightBtn: confirm) {
            
        }
        let typeImage = PopupType.alertWithImage(title: title, image: UIImage(named: "ic_fail_circle_red", in: Bundle.resourceBundle(for: PopupManager.self), compatibleWith: nil) ?? UIImage(), content: content, titleRightBtn: confirm) {
                        
        }
        
        
        

        pushToPopupVC(vc: vc, type: typeConfirm)
    }
    
    public func pushToPopupVC(vc:UIViewController, type: PopupType, actionClose : (()->Void)? = nil){
        guard let vcPopup = UIStoryboard(name: "Popup", bundle: Bundle.resourceBundle(for: PopupManager.self)).instantiateViewController(withIdentifier: "PopupVC") as? PopupVC else {return}
//        vcPopup.setupUI(popupType: type,title: title,actionClose: actionClose)
        vcPopup.setupUI(popupType: type, actionClose: actionClose)
        vcPopup.modalPresentationStyle = .overFullScreen
         vc.present(vcPopup, animated: false)
    }
}
