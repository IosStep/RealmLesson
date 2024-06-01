//
//  UIViewExt.swift
//  RealmProjectShowCase
//
//  Created by Aldiyar Aitpayev on 25.05.2024.
//

import UIKit


extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview(_:))
    }
}
