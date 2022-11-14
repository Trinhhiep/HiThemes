//
//  DropDownTableViewCell.swift
//  Hi FPT
//
//  Created by TaiHA on 29/08/2021.
//

import UIKit

class DropDownTableViewCell : UITableViewCell {
    
    @IBOutlet weak var imvTitle: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btn_Action: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
