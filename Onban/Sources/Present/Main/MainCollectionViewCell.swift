//
//  MainCollectionViewCell.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
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
        horizontalStackView.distribution = .equalCentering
        horizontalStackView.alignment = .firstBaseline
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
    
    // TODO: - 이벤트 패딩레이블 만들어서 eventStackView에 추가하는 코드 추가해야함
    func setup<T: Codable>(with object: T) {
        imageView.image = UIImage(named: "mockImage.png")
        title.text = "오리 주물럭_반조리"
        body.text = "감질맛 나는 매콤한 양념"
        reducedPrice.text = "12,640원"
        originPrice.text = "15,800원"
    }
    
    // MARK: - DTO 설정되면 지울 메서드
    func setup() {
        imageView.image = UIImage(named: "mockImage.png")
        title.text = "오리 주물럭_반조리"
        body.text = "감질맛 나는 매콤한 양념"
        reducedPrice.text = "12,640원"
        originPrice.text = "15,800원"
    }
}
