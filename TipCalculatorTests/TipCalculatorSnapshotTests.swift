//
//  TipCalculatorSnapshotTests.swift
//  TipCalculatorTests
//
//  Created by KSH on 7/30/24.
//

import XCTest
import SnapshotTesting
@testable import TipCalculator

final class TipCalculatorSnapshotTests: XCTestCase {
    
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLgoView() {
        // given
        let size = CGSize(width: screenWidth, height: 48)
        // when
        let view = LogoView()
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testInitalResultView() {
        // given
        let size = CGSize(width: screenWidth, height: 224)
        // when
        let view = ResultView()
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testResultViewWithValues() {
        // given
        let size = CGSize(width: screenWidth, height: 224)
        let result = Result(
            amountPerPerson: 100.25,
            totalBill: 45,
            totalTip: 60
        )
        // when
        let view = ResultView()
        view.configure(result: result)
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testInitalBillInputView() {
        // given
        let size = CGSize(width: screenWidth, height: 56)
        // when
        let view = BillInputView()
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testBillInputViewWithValues() {
        // given
        let size = CGSize(width: screenWidth, height: 56)
        // when
        let view = BillInputView()
        let textField = view.allSubViewsOf(type: UITextField.self).first
        textField?.text = "500"
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testInitalTipInputView() {
        // given
        let size = CGSize(width: screenWidth, height: 56+56+16)
        // when
        let view = TipInputView()
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testTipInputViewWithValues() {
        // given
        let size = CGSize(width: screenWidth, height: 56+56+16)
        // when
        let view = TipInputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testInitalSplitInputView() {
        // given
        let size = CGSize(width: screenWidth, height: 56)
        // when
        let view = SplitInputView()
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
    
    func testSplitInputViewWithValues() {
        // given
        let size = CGSize(width: screenWidth, height: 56)
        // when
        let view = SplitInputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        // then
        assertSnapshot(of: view, as: .image(size: size))
    }
}

extension UIView {
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
            all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}
