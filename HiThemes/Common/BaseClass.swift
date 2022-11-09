//
//  BaseClass.swift
//  MiniAppCore
//
//  Created by Trinh Quang Hiep on 16/09/2022.
//

import Foundation
import UIKit
public class BaseClass: NSObject{
    deinit{
        debugPrint("---------------\(String(describing: type(of: self))) disposed-------------")
    }
}
open class BaseViewController: UIViewController{
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    deinit{
        debugPrint("---------------\(String(describing: type(of: self))) disposed-------------")
    }
}
