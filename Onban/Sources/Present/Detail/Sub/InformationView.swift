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
        return label
    }()
    
    private let body: UILabel = {
        let label = UILabel()
        label.font = UIFont.textMediumRegular
        label.textColor = UIColor.grey2
        return label
    }()
    
    private let reducedPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.textMediumBold
        label.textColor = UIColor.grey1
        return label
    }()
    
    private let originPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.textMediumRegular
        label.textColor = UIColor.grey2
        return label
    }()
    
    private let eventStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.alignment = .firstBaseline
        horizontalStackView.spacing = LayoutConstant.badgeSpacing
        return horizontalStackView
    }()
    
    private let priceStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.spacing = LayoutConstant.interSpacing
        horizontalStackView.alignment = .firstBaseline
        return horizontalStackView
    }()
    
    private let descriptionStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
        verticalStackView.spacing = LayoutConstant.interSpacing
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
        return label
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LayoutConstant.interSpacing
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    private let bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LayoutConstant.interSpacing
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
            $0.leading.equalToSuperview().offset(LayoutConstant.edgeSpacing)
            $0.trailing.equalToSuperview().inset(LayoutConstant.edgeSpacing)
            $0.top.equalToSuperview().offset(LayoutConstant.spacingOfSection)
        }
        
        midDividingLine.snp.makeConstraints {
            $0.top.equalTo(descriptionStackView.snp.bottom).offset(LayoutConstant.spacingOfSection)
            $0.leading.trailing.equalTo(descriptionStackView)
            $0.height.equalTo(LayoutConstant.lineHeight)
        }
        
        titleStackView.snp.makeConstraints {
            $0.leading.equalTo(descriptionStackView)
            $0.top.equalTo(midDividingLine.snp.bottom).offset(LayoutConstant.spacingOfSection)
        }
        
        bodyStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView)
            $0.leading.equalTo(titleStackView.snp.trailing).offset(LayoutConstant.edgeSpacing)
        }
        
        lastDividingLine.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(LayoutConstant.spacingOfSection)
            $0.leading.trailing.equalTo(descriptionStackView)
            $0.height.equalTo(LayoutConstant.lineHeight)
        }
    }
}

extension InformationView {
    func setupInformations(_ viewModel: DetailViewModel) {
        self.eventStackView.removeAllSubviews()
        
        self.title.text = viewModel.title
        self.body.text = viewModel.body
        if let originPrice = viewModel.originPrice {
            self.originPrice.attributedText = UIFactory.makeAttributedString(originPrice.asPriceString)
        }
        self.reducedPrice.text = viewModel.reducedPrice.asPriceString
        self.deliveryChargeValue.text = viewModel.deliveryCharge
        self.deliveryInfomationValue.text = viewModel.deliveryInfo
        self.savedMoneyValue.text = viewModel.savedMoney.asPriceString
        self.eventStackView.addArrangedSubViews(UIFactory.makeEventBadges(viewModel.events))
    }
}
