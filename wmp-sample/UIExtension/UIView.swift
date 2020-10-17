//
//  UIView.swift
//  wmp-sample
//
//  Created by Yun Ha on 2020/10/17.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
