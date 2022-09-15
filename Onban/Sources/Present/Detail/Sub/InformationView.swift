//
//  InformationView.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/13.
//

import UIKit
import SnapKit

class InformationView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This init shouldn't be used")
    }
    
    private(set) var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.textLargeBold
        label.textColor = UIColor.black
        label.text = "오리 주물럭_반조리"
        return label
    }()
    
    private let body: UILabel = {
        let label = UILabel()
        label.font = UIFont.textMediumRegular
        label.textColor = UIColor.grey2
        label.text = "감칠맛 나는 매콤한 양념"
        return label
    }()
    
    private let reducedPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.textMediumBold
        label.textColor = UIColor.grey1
        label.text = "12,640원"
        return label
    }()
    
    private let originPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.textMediumRegular
        label.attributedText = UIFactory.makeAttributedString()
        label.textColor = UIColor.grey2
        label.text = "15,800원"
        return label
    }()
    
    private let eventStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.alignment = .firstBaseline
        horizontalStackView.spacing = 4
        return horizontalStackView
    }()
    
    private let priceStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.spacing = 8
        horizontalStackView.alignment = .firstBaseline
        return horizontalStackView
    }()
    
    private let descriptionStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
        verticalStackView.spacing = 8
        verticalStackView.alignment = .leading
        return verticalStackView
    }()
    
    private let midDividingLine = UIFactory.makeDividingLine()
    
    private let lastDividingLine = UIFactory.makeDividingLine()
    
    private let savedMoney: UILabel = {
        let label = UILabel()
        label.font = UIFont.textSmallRegular
        label.textColor = UIColor.grey2
        label.text = "적립금"
        return label
    }()
    
    private let deliveryInfomation: UILabel = {
        let label = UILabel()
        label.font = UIFont.textSmallRegular
        label.textColor = UIColor.grey2
        label.text = "배송정보"
        return label
    }()
    
    private let deliveryCharge: UILabel = {
        let label = UILabel()
        label.font = UIFont.textSmallRegular
        label.textColor = UIColor.grey2
        label.text = "배송비"
        return label
    }()
    
    private let savedMoneyValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.textSmallRegular
        label.textColor = UIColor.grey1
        label.text = "126원"
        return label
    }()
    
    private let deliveryInfomationValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.textSmallRegular
        label.textColor = UIColor.grey1
        label.text = "서울 경기 새벽 배송, 전국 택배 배송"
        return label
    }()
    
    private let deliveryChargeValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.textSmallRegular
        label.textColor = UIColor.grey1
        label.text = "2,500원 (40,000원 이상 구매 시 무료)"
        return label
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    private let bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    private func setupLayout() {
        self.backgroundColor = UIColor.white
        let outerViews = [descriptionStackView, midDividingLine, titleStackView, bodyStackView, lastDividingLine]
        self.addSubViews(outerViews)
        
        let eventTags = UIFactory.makeEventBadges([.mainSpecialPrice])
        eventStackView.addArrangedSubViews(eventTags)
        
        let priceSubViews = [reducedPrice, originPrice]
        priceStackView.addArrangedSubViews(priceSubViews)
        
        let descriptionSubViews = [title, body, priceStackView, eventStackView]
        descriptionStackView.addArrangedSubViews(descriptionSubViews)
        
        let titleLabelSubViews = [savedMoney, deliveryInfomation, deliveryCharge]
        titleStackView.addArrangedSubViews(titleLabelSubViews)
        
        let bodySubViews = [savedMoneyValue, deliveryInfomationValue, deliveryChargeValue]
        bodyStackView.addArrangedSubViews(bodySubViews)
                
        descriptionStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(24)
        }
        
        midDividingLine.snp.makeConstraints {
            $0.top.equalTo(descriptionStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(descriptionStackView)
            $0.height.equalTo(1)
        }
        
        titleStackView.snp.makeConstraints {
            $0.leading.equalTo(descriptionStackView)
            $0.top.equalTo(midDividingLine.snp.bottom).offset(24)
        }
        
        bodyStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView)
            $0.leading.equalTo(titleStackView.snp.trailing).offset(16)
        }
        
        lastDividingLine.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(descriptionStackView)
            $0.height.equalTo(1)
        }
    }
}
