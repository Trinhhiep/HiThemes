//
//  CustomView.swift
//  HiThemes
//
//  Created by Trinh Quang Hiep on 14/11/2022.
//

import Foundation
import UIKit
struct DropViewModel {
    var imv:String?
    var title:String?
    var typeImage: TypeImage = .ic
}
enum TypeImage{
    case url, ic
}
//
//  DropDownView.swift
//  Hi FPT
//
//  Created by TaiHA on 28/08/2021.
//


import Kingfisher

class DropDownView : UIView {
    

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var vDropView: UIView!
    @IBOutlet weak var mTableView: UITableView!
    var onSelect: ((Int) -> Void)?
    var arrData : [DropViewModel]?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("DropDownView", owner: self, options: nil)
        addSubview(vContent)
        vContent.frame = self.bounds
        vContent.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vDropView.roundCorner(borderColor: #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1), borderWidth: 1, cornerRadius: 5)
        setupTableView()
    }
    
    func setupTableView(){
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.register(UINib(nibName: "DropDownTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownTableViewCell")
        mTableView.isUserInteractionEnabled = true
        mTableView.allowsSelection = true

    }

    
    func removeDescription(){
        self.removeFromSuperview()
    }
}

extension DropDownView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell", for: indexPath) as? DropDownTableViewCell else { return UITableViewCell() }
        if arrData?[indexPath.row].typeImage == .ic {
            if arrData?[indexPath.row].imv != ""{
                cell.imvTitle.image = UIImage(named: arrData?[indexPath.row].imv ?? "")
                cell.imvTitle.isHidden = false
            }else{
                cell.imvTitle.isHidden = true
            }
            
        }
        else
        {
            if let urlImage = URL(string: arrData?[indexPath.row].imv ?? "") {
                cell.imvTitle.kf.setImage(with: urlImage)
            }
        }
        cell.lblTitle.text = arrData?[indexPath.row].title
        cell.btn_Action.tag = indexPath.row
        cell.btn_Action.addTarget(self, action: #selector(ActionType), for: UIControl.Event.touchUpInside)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        onSelect?(indexPath.row)
//        print("\(indexPath.row)")
//    }
    
    @objc func ActionType (sender : UIButton) {
        // click vào mỗi nút tương ứng với từng item theo sender.tag
        onSelect?(sender.tag)
    }
    
}

class DialogContainerView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view is Self {
            removeFromSuperview()
        }
        
        if view is UIButton {
            return view
        }
        return nil
    }
}
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
