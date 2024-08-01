//
//  ScreenIdentifier.swift
//  TipCalculator
//
//  Created by KSH on 7/31/24.
//

import Foundation

enum ScreenIdentifier {
    
    enum Logoview: String {
        case logoView
    }
    
    enum ResultView: String {
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    enum BillInputView: String {
        case textField
    }
    
    enum TipInputView: String {
        case tenPercentButton
        case fifteenPercentButton
        case twentyPercentButton
        case customTipButton
        case customTipAlertTextField
    }
    
    enum SplitInputView: String {
        case decrementButton
        case increMentButton
        case quantityValueLabel
    }
    
    
}
