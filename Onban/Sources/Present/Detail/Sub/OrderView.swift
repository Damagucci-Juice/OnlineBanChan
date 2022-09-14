//
//  OrderView.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/14.
//

import UIKit
import SnapKit

class OrderView: UIView {
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
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
        return label
    }()
    
    private let amountCountBody: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.grey1
        label.font = UIFont.textMediumBold
        label.text = "1"
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
        self.addSubview(containerStackView)
        
        let outerSubViews = [amountStackView, midDividingLine, totalPriceStackView, orderButton]
//        let outerSubViews = [amountStackView]
        containerStackView.addArrangedSubViews(outerSubViews)
        
        let amountSubViews = [amountCountLabel, amountCountBody, stepper]
        amountStackView.addArrangedSubViews(amountSubViews)
        
        let totalSubViews = [totalPriceLabel, totalPriceBody]
        totalPriceStackView.addArrangedSubViews(totalSubViews)
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        amountStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        amountCountLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        stepper.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        amountCountBody.snp.makeConstraints { make in
            make.trailing.equalTo(stepper.snp.leading)
        }
        
        midDividingLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalTo(amountStackView)
        }

        totalPriceStackView.snp.makeConstraints { make in
            make.trailing.equalTo(amountStackView)
        }

        orderButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(amountStackView)
            make.height.equalTo(50)
        }
        
    }
    
    private func setupAttribute() {
        self.backgroundColor = UIColor.brown
        self.amountStackView.backgroundColor = UIColor.primary1
        self.totalPriceStackView.backgroundColor = UIColor.grey4
    }
}
