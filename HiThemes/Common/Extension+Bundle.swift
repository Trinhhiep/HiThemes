//
//  Bundle+Extensions.swift
//  FTelShopSDK
//
//  Created by NgocHTN6 on 11/01/2022.
//


import Foundation
extension Bundle {
    public static func resourceBundle(for frameworkClass: AnyClass) -> Bundle {
        
        guard let bundle = Bundle(identifier: "com.veritran.MiniAppCore") else {
            fatalError("==bundle not found in \(bundle)")
        }
        return bundle
    }
    public static func bundle() -> Bundle {
        guard let bundleIndentifer = Bundle.main.bundleIdentifier else { return Bundle() }
        guard let bundel = Bundle(identifier: bundleIndentifer) else { return Bundle() }
        return bundel
    }
}
