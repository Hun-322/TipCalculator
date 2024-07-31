//
//  AmountView.swift
//  TipCalculator
//
//  Created by KSH on 7/22/24.
//

import UIKit

class AmountView: UIView {
    
    private let title: String
    private let textAlignment: NSTextAlignment
    private let amountLableIdentifier: String
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(
            text: title,
            font: ThemeFont.regular(ofSize: 18),
            textColor: ThemeColor.text,
            textAlignment: textAlignment
        )
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(
            string: "₩0",
            attributes: [
                .font: ThemeFont.bold(ofSize: 24)
            ])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 16)
        ], range: NSMakeRange(0, 1)
        )
        label.attributedText = text
        label.accessibilityIdentifier = amountLableIdentifier
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    init(title: String, textAlignment: NSTextAlignment, amountLableIdentifier: String) {
        self.title = title
        self.textAlignment = textAlignment
        self.amountLableIdentifier = amountLableIdentifier
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(amount: Double) {
        let text = NSMutableAttributedString(
            string: amount.currencyFormatted,
            attributes: [
                .font: ThemeFont.bold(ofSize: 24)
            ])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 16)
        ], range: NSMakeRange(0, 1)
        )
        amountLabel.attributedText = text
    }
    
    private func layout() {
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
