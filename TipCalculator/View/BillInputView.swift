//
//  BillInputView.swift
//  TipCalculator
//
//  Created by KSH on 7/22/24.
//

import UIKit

class BillInputView: UIView {
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .blue
    }
}
