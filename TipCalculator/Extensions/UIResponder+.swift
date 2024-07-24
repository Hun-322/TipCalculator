//
//  UIResponder+.swift
//  TipCalculator
//
//  Created by KSH on 7/24/24.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
