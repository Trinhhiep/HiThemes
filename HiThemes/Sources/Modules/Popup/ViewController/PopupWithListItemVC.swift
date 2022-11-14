//
//  PopupWithListItemVC.swift
//  HiThemes
//
//  Created by Trinh Quang Hiep on 11/11/2022.
//

import UIKit
public protocol PopupWithListItemVCDelegate{
    
    func viewForCellAt(indexPath: IndexPath)-> UIView
    func numberOfRowsInSection(section : Int) -> Int
    func didSelectRowAt(indexPath: IndexPath)
    //    func setDismissWhenSelectRow()->Bool
}
//public extension PopupWithListItemVCDelegate{
//    func setDismissWhenSelectRow()->Bool{
//        return true
//    }
//}
class PopupWithListItemVC: BaseViewController {
    
    @IBOutlet weak var lblTitlePopup: LabelTitlePopup!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet  weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var delegate : PopupWithListItemVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 16
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        containerView.showHidePopup(background: self.view, animationType: .ShowBottomTop)
        self.tableView.performBatchUpdates { [weak self] in
            guard let _self = self else {return}
            _self.tableView.reloadData()
        } completion: { [weak self] _ in
            guard let _self = self else {return}
            _self.tableViewHeight?.constant = _self.tableView.contentSize.height
        }
    }
    @IBAction func actionClose(_ sender: Any) {
        dismissPopup()
    }
    func dismissPopup(){
        containerView.showHidePopup(background: self.view, animationType: .HideBottomTop)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: false, completion: {})
        }
    }
    
}

extension PopupWithListItemVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let subView = delegate?.viewForCellAt(indexPath: indexPath) else {return cell}
        cell.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            subView.topAnchor.constraint(equalTo: cell.topAnchor),
            subView.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            
        ])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfRowsInSection(section: section) ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissPopup()
        delegate?.didSelectRowAt(indexPath: indexPath)
        
    }
}
