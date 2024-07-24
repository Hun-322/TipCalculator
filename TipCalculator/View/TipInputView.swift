//
//  TipInputView.swift
//  TipCalculator
//
//  Created by KSH on 7/22/24.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(
            topText: "Choose",
            bottomText: "your tip"
        )
        return view
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        button.tapPublisher.flatMap ({
            Just(Tip.tenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var fiftenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fiftenPercent)
        button.tapPublisher.flatMap ({
            Just(Tip.fiftenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.tapPublisher.flatMap ({
            Just(Tip.twentyPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8.0)
        return button
    }()
    
    private lazy var buttonHSatckView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tenPercentTipButton,
            fiftenPercentTipButton,
            twentyPercentTipButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var buttonVSatckView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buttonHSatckView,
            customTipButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        layout()
        print("tip: \(tipSubject.value)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [headerView, buttonVSatckView].forEach(addSubview(_:))
        
        buttonVSatckView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonVSatckView.snp.leading).offset(-24)
            make.width.equalTo(68)
            make.centerY.equalTo(buttonHSatckView.snp.centerY)
        }
    }
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: ThemeFont.bold(ofSize: 20),
                .foregroundColor: UIColor.white
            ]
        )
        text.addAttributes([
            .font: ThemeFont.demibold(ofSize: 14)
        ], range: NSMakeRange(2, 1)
        )
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}
