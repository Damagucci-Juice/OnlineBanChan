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
        stackView.spacing = LayoutConstant.spacingOfSection
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
    
    private let touchedButtonAction: UIAction = UIAction { _ in
        print("button touched")
    }
    
    private let orderButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.primary2
        button.setTitle("주문하기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.textMediumBold
        button.layer.cornerRadius = LayoutConstant.cornerRadiusOfButton
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
            make.leading.top.equalToSuperview().offset(LayoutConstant.edgeSpacing)
            make.trailing.equalToSuperview().inset(LayoutConstant.edgeSpacing)
        }
        
        amountCountLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        stepper.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(95)
            make.height.lessThanOrEqualTo(LayoutConstant.buttonHeight)
        }
        
        amountCountBody.snp.makeConstraints { make in
            make.trailing.equalTo(stepper.snp.leading)
            make.width.lessThanOrEqualTo(LayoutConstant.buttonHeight)
        }
        
        midDividingLine.snp.makeConstraints { make in
            make.height.equalTo(LayoutConstant.lineHeight)
            make.leading.trailing.equalTo(amountStackView)
            make.top.equalTo(amountStackView.snp.bottom).offset(LayoutConstant.edgeSpacing)
        }

        totalPriceStackView.snp.makeConstraints { make in
            make.top.equalTo(midDividingLine.snp.bottom).offset(LayoutConstant.edgeSpacing)
            make.trailing.equalTo(amountStackView)
        }

        orderButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(amountStackView)
            make.height.equalTo(LayoutConstant.buttonHeight)
            make.top.equalTo(totalPriceStackView.snp.bottom).offset(LayoutConstant.edgeSpacing)
        }
        
    }
    
    private func setupAttribute() {
        self.backgroundColor = UIColor.white
        orderButton.addAction(touchedButtonAction, for: .touchUpInside)
    }
}
