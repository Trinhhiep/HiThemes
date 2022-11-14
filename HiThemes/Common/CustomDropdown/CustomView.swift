//
//  DropDownView.swift
//  FTelShopSDK
//
//  Created by TaiHA on 12/27/21.
//

import UIKit
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
        let bundel = Bundle(for: DropDownView.self)
        bundel.loadNibNamed("DropDownView", owner: self, options: nil)
        addSubview(vContent)
        vContent.frame = self.bounds
        vContent.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vDropView.roundCorner(borderColor: #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1), borderWidth: 1, cornerRadius: 5)
        setupTableView()
    }
    
    func setupTableView(){
        mTableView.delegate = self
        mTableView.dataSource = self
//        mTableView.registerCell(cellName: DropDownTableViewCell.self)
        mTableView.register(UINib(nibName: "DropDownTableViewCell", bundle: Bundle.resourceBundle(for: DropDownView.self)), forCellReuseIdentifier: "DropDownTableViewCell")
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
            cell.imvTitle.image = UIImage(named: arrData?[indexPath.row].imv ?? "" , in: Bundle.resourceBundle(for: DropDownView.self), compatibleWith: nil)
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

struct DropViewModel {
    var imv:String?
    var title:String?
    var typeImage: TypeImage = .ic
}
enum TypeImage{
    case url, ic
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
