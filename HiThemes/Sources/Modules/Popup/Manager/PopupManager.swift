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
//        presentToPopupVC(vc: vc, type: typeConfirm)
        presentToPopupWithImageVC(vc: vc, titlePopup: title,
                                  contentPopup: content,
                                  imagePopup: UIImage(named: "img_Mascot", in: Bundle.resourceBundle(for: PopupManager.self), compatibleWith: nil) ?? UIImage(),
                                  rightBtnTitle: "Confirm")
    }
    
    public func presentToPopupVC(vc:UIViewController, type: PopupType, actionClose : (()->Void)? = nil){
        guard let vcPopup = UIStoryboard(name: "Popup", bundle: Bundle.resourceBundle(for: PopupManager.self)).instantiateViewController(withIdentifier: "PopupVC") as? PopupVC else {return}
        vcPopup.setupUI(popupType: type, actionClose: actionClose)
        vcPopup.modalPresentationStyle = .overFullScreen
         vc.present(vcPopup, animated: false)
    }
    
    public func presentToPopupWithImageVC(vc:UIViewController,
                                          titlePopup: String,
                                          contentPopup: NSMutableAttributedString,
                                          imagePopup: UIImage,
                                          rightBtnTitle: String){
        guard let vcPopup = UIStoryboard(name: "Popup", bundle: Bundle.resourceBundle(for: PopupManager.self)).instantiateViewController(withIdentifier: "PopupWithImageVC") as? PopupWithImageVC else {return}
        vcPopup.setupDataUI(titlePopup: titlePopup,
                            contentPopup: contentPopup,
                            imagePopup: imagePopup,
                            rightBtnTitle: rightBtnTitle)
        vcPopup.modalPresentationStyle = .overFullScreen
         vc.present(vcPopup, animated: false)
    }
}
