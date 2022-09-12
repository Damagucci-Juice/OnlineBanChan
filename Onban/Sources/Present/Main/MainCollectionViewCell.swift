//
//  MainCollectionViewCell.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    private weak var imageManager = ImageManager.shared
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = UIColor.grey3
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.textSmallBold
        label.textColor = UIColor.black
        return label
    }()
    
    private let body: UILabel = {
        let label = UILabel()
        label.font = UIFont.textSmallRegular
        label.textColor = UIColor.grey2
        return label
    }()
    
    private let reducedPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.textSmallBold
        label.textColor = UIColor.black
        return label
    }()
    
    private let originPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.textSmallBold
        let string = "0원"
        let attributeString = NSMutableAttributedString(string: string)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: 2,
            range: NSRange(location: 0, length: attributeString.length)
        )
        label.attributedText = attributeString
        label.textColor = UIColor.grey2
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
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This initializer shouldn't be used")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviews() 
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubViews([imageView, descriptionStackView])
        priceStackView.addArrangedSubViews([reducedPrice, originPrice])
        descriptionStackView.addArrangedSubViews([title, body, priceStackView, eventStackView])
        
        imageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.width.equalTo(130)
            $0.height.equalTo(imageView.snp.width)
        }
        
        descriptionStackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setup(_ dish: DishDTO) {
        guard let url = URL(string: dish.image) else { return }
        Task {
            imageView.image = await imageManager?.loadImage(url: url)
        }
        title.text = dish.title
        body.text = dish.bodyDescription
        reducedPrice.text = dish.reducedPrice
        originPrice.text = dish.originPrice
        eventStackView.addArrangedSubViews(PaddingLabelFactory.makeEventBadges(dish.eventBadge))
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        title.text = .none
        body.text = .none
        reducedPrice.text = .none
        originPrice.text = .none
        eventStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
