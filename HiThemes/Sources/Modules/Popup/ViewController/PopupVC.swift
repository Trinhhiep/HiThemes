//
//  PopupVC.swift
//  HiThemes
//
//  Created by Trinh Quang Hiep on 10/11/2022.
//

import UIKit
public enum PopupType{
    case confirm(title: String,
                 content: NSMutableAttributedString,
                 titleLeftBtn: String,
                 titleRightBtn: String,
                 actionLeftBtn : (()->Void)?,
                 actionRightBtn : (()->Void)?) // content , 2 button
    case alert(title: String,
               content: NSMutableAttributedString,
               titleRightBtn: String,
               actionRightBtn : (()->Void)?)  // content , 1 button
    case alertWithImage(title: String,
                        image: UIImage,
                        content: NSMutableAttributedString,
                        titleRightBtn: String,
                        actionRightBtn : (()->Void)?)  // image, content, 1 button
}
public class PopupVC: UIViewController {
    @IBOutlet weak var popupContainer: UIView!
    @IBOutlet weak var lblTitle: LabelTitlePopup!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var stackContent: UIStackView!
    
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lblContent: UILabel!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: ButtonPrimary!
    
    private var popupType : PopupType?
    private var titlePopup : String = ""
    private var contentPopup : NSMutableAttributedString?
    private var imagePopup : UIImage?
    private var leftBtnTitle : String?
    private var rightBtnTitle : String?
    
    var callbackActionLeftButton : (()->Void)?
    var callbackActionRightButton : (()->Void)?
    var callbackActionCloseButton : (()->Void)?
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    func initUI(){
        popupContainer.layer.cornerRadius = 16
        btnClose.setImage(UIImage(named: "ic_close_inpopup_gray",in: Bundle.resourceBundle(for: PopupVC.self),compatibleWith: nil), for: .normal)
        lblContent.textColor = UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1)
        lblContent.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        leftButton.setTitleColor(UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1), for: .normal)
        rightButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        addAction()
    }
    func addAction(){
        btnClose.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(leftBtnAction), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightBtnAction), for: .touchUpInside)
    }
    @objc func leftBtnAction(){
        callbackActionLeftButton?()
    }
    
    @objc func rightBtnAction(){
        callbackActionRightButton?()
    }
    @objc func closeBtnAction(){
        UIView.animate(withDuration: 0.2, delay: 0,
                       options: [.curveEaseInOut, .transitionCrossDissolve], animations: {[weak self] in
            self?.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }) { [weak self] _ in
            self?.dismiss(animated: false)
            self?.callbackActionCloseButton?()
        }
    }
    
    
    func setupUI(popupType : PopupType, actionClose: (()->Void)?){
        self.popupType = popupType
        callbackActionCloseButton = actionClose
        switch popupType {
        case .confirm(let title,let content, let titleLeftBtn, let titleRightBtn, let actionLeft, let actionRight):
            self.titlePopup = title
            self.contentPopup = content
            self.leftBtnTitle = titleLeftBtn
            self.rightBtnTitle = titleRightBtn
            callbackActionLeftButton = actionLeft
            callbackActionRightButton = actionRight
        case .alert(let title,let content, let titleRightBtn, let actionRight):
            self.titlePopup = title
            self.contentPopup = content
            self.rightBtnTitle = titleRightBtn
            callbackActionRightButton = actionRight
        case .alertWithImage(let title,let image, let content, let titleRightBtn, let actionRight):
            self.titlePopup = title
            self.contentPopup = content
            self.rightBtnTitle = titleRightBtn
            self.imagePopup = image
            callbackActionRightButton = actionRight
        }
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fillUI()
    }
    func fillUI(){
        guard let popupType = popupType else {
            return
        }
        switch popupType {
        case .confirm:
            lblTitle.text = self.titlePopup
            imgView.isHidden = true
            lblContent.attributedText = self.contentPopup
            leftButton.setTitle(self.leftBtnTitle, for: .normal)
            rightButton.setTitle(self.rightBtnTitle, for: .normal)
         
        case .alert:
            lblTitle.text = self.titlePopup
            imgView.isHidden = true
            lblContent.attributedText = self.contentPopup
            leftButton.setTitle("", for: .normal) // hidden text only
            leftButton.isEnabled = false
            rightButton.setTitle(self.rightBtnTitle, for: .normal)
            
        case .alertWithImage:
            lblTitle.text = self.titlePopup
            imgView.isHidden = false
            imgIcon.image = self.imagePopup
            lblContent.attributedText = self.contentPopup
            leftButton.setTitle("", for: .normal) // hidden text only
            leftButton.isEnabled = false
            rightButton.setTitle(self.rightBtnTitle, for: .normal)
            
        }
    }
    
}
