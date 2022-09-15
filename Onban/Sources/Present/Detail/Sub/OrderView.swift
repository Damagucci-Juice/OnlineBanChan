//
//  OrderView.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/14.
//

import UIKit
import SnapKit

class OrderView: UIView {
    
    private let amountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()
    
    private let amountCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.grey2
        label.font = UIFont.textSmallRegular
        label.text = "수량"
        label.sizeToFit()
        return label
    }()
    
    private let amountCountBody: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.grey1
        label.font = UIFont.textMediumBold
        label.text = "1"
        label.sizeToFit()
        return label
    }()
    
    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.backgroundColor = UIColor.grey4
        stepper.isContinuous = false
        stepper.minimumValue = 1
        stepper.autorepeat = true
        stepper.stepValue = 1
        stepper.value = 1
        stepper.sizeToFit()
        return stepper
    }()
    
    private let midDividingLine = UIFactory.makeDividingLine()
    
    private let totalPriceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 24
        return stackView
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.grey2
        label.font = UIFont.textMediumBold
        label.text = "총 주문금액"
        return label
    }()
    
    private let totalPriceBody: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.textLargeBold
        label.text = "10,000원"
        return label
    }()
    
    private let orderButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.primary2
        button.setTitle("주문하기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.textMediumBold
        button.layer.cornerRadius = 10
        button.isEnabled = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupAttribute()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This init shouldn't be used")
    }
    
    private func setupLayout() {
        let outerSubViews = [amountStackView, midDividingLine, totalPriceStackView, orderButton]
        self.addSubViews(outerSubViews)
        
        let amountSubViews = [amountCountLabel, amountCountBody, stepper]
        amountStackView.addArrangedSubViews(amountSubViews)
        
        let totalSubViews = [totalPriceLabel, totalPriceBody]
        totalPriceStackView.addArrangedSubViews(totalSubViews)
        
        amountStackView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        amountCountLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        stepper.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(100)
            make.height.lessThanOrEqualTo(50)
        }
        
        amountCountBody.snp.makeConstraints { make in
            make.trailing.equalTo(stepper.snp.leading)
            make.width.lessThanOrEqualTo(50)
        }
        
        midDividingLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalTo(amountStackView)
            make.top.equalTo(amountStackView.snp.bottom).offset(16)
        }

        totalPriceStackView.snp.makeConstraints { make in
            make.top.equalTo(midDividingLine.snp.bottom).offset(16)
            make.trailing.equalTo(amountStackView)
        }

        orderButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(amountStackView)
            make.height.equalTo(50)
            make.top.equalTo(totalPriceStackView.snp.bottom).offset(16)
        }
        
    }
    
    private func setupAttribute() {
        self.backgroundColor = UIColor.white
    }
}
