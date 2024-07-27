//
//  TipCalculatorTests.swift
//  TipCalculatorTests
//
//  Created by KSH on 7/22/24.
//

import XCTest
import Combine
@testable import TipCalculator

final class TipCalculatorTests: XCTestCase {
    // sut -> System Under Test
    private var sut: CalculatorVM!
    private var cancellables: Set<AnyCancellable>!
    private var logoViewTapSubject: PassthroughSubject<Void, Never>!
    
    override func setUp() {
        sut = .init()
        logoViewTapSubject = .init()
        cancellables = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
        logoViewTapSubject = nil
    }
    
    //    - 1000원
    //    - 팁 없음
    //    - 1명
    func test_한명이팁을안주는경우() {
        // given: 필요한 value 세팅
        let bill: Double = 1000.0
        let tip: Tip = .none
        let split: Int = 1
        let input = buildInput(
            bill: bill,
            tip: tip,
            split: split
        )
        // when: 테스트 코드 실행
        let output = sut.transform(input: input)
        // then: 결과 확인(출력)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 1000.0)
            XCTAssertEqual(result.totalBill, 1000)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher()
        )
    }
}
