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
    func test_1명이팁을안주는경우() {
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
    
    func test_2명이팁을안주는경우() {
        // given: 필요한 value 세팅
        let bill: Double = 1000.0
        let tip: Tip = .none
        let split: Int = 2
        let input = buildInput(
            bill: bill,
            tip: tip,
            split: split
        )
        // when: 테스트 코드 실행
        let output = sut.transform(input: input)
        // then: 결과 확인(출력)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 500.0)
            XCTAssertEqual(result.totalBill, 1000)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    func test_2명이팁을10퍼센트주는경우() {
        // given: 필요한 value 세팅
        let bill: Double = 1000.0
        let tip: Tip = .tenPercent
        let split: Int = 2
        let input = buildInput(
            bill: bill,
            tip: tip,
            split: split
        )
        // when: 테스트 코드 실행
        let output = sut.transform(input: input)
        // then: 결과 확인(출력)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 550.0)
            XCTAssertEqual(result.totalBill, 1100)
            XCTAssertEqual(result.totalTip, 100)
        }.store(in: &cancellables)
    }
    
    func test_4명이커스텀팁을주는경우() {
        // given: 필요한 value 세팅
        let bill: Double = 2000.0
        let tip: Tip = .custom(value: 201)
        let split: Int = 4
        let input = buildInput(
            bill: bill,
            tip: tip,
            split: split
        )
        // when: 테스트 코드 실행
        let output = sut.transform(input: input)
        // then: 결과 확인(출력)
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 550.25)
            XCTAssertEqual(result.totalBill, 2201)
            XCTAssertEqual(result.totalTip, 201)
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
