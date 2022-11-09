//
//  HiFMiniAppSDK.swift
//  MiniAppCore
//
//  Created by HiepTQ5 on 9/11/22
//

import Foundation
import UIKit


public protocol HiThemesDelegate: AnyObject {

}

public class HiThemesSDK {
    var vc: UIViewController
  
    public init(vc: UIViewController) {
        debugPrint("init: MiniAppCoreSDK")
        self.vc = vc
    }
    deinit{
        debugPrint("deinit: MiniAppCoreSDK")
    }
    
}
