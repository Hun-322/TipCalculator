//
//  CalculatorVM.swift
//  TipCalculator
//
//  Created by KSH on 7/24/24.
//

import Foundation
import Combine

class CalculatorVM {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct OutPut {
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func transform(input: Input) -> OutPut {
        
        input.tipPublisher.sink { tip in
            print(tip)
        }.store(in: &cancellables)
        
        let result = Result(
            amountPerPerson: 500,
            totalBill: 1000,
            totalTip: 50.0
        )
        
        return OutPut(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
}
