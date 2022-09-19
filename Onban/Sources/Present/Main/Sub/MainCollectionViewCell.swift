//
//  MainCollectionViewCell.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit
import RxSwift
import Kingfisher

final class MainCollectionViewCell: UICollectionViewCell {
    
    private weak var imageManager = ImageManager.shared
    
    private var disposeBag = DisposeBag()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = LayoutConstant.cornerRadiusOfButton
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
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
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
        label.font = UIFont.textSmallRegular
        label.attributedText = UIFactory.makeAttributedString()
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
    
    private func setupLayout() {
        contentView.addSubViews([imageView, descriptionStackView])
        priceStackView.addArrangedSubViews([reducedPrice, originPrice])
        descriptionStackView.addArrangedSubViews([title, body, priceStackView, eventStackView])
        
        imageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.width.equalTo(LayoutConstant.cellHeight)
            $0.height.equalTo(imageView.snp.width)
        }
        
        descriptionStackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(LayoutConstant.interSpacing)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This initializer shouldn't be used.")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.eventStackView.removeAllSubviews()
        self.disposeBag = DisposeBag()
    }
}

extension MainCollectionViewCell: View {
    func bind(to viewModel: MainCellViewModel) {
        viewModel.state.entityReady
            .withUnretained(self)
            .bind(onNext: { (cell, entity) in
                cell.setupCellViews(entity)
            })
            .disposed(by: disposeBag)

        viewModel.action.loadCell.accept(())
    }
    
    private func setupCellViews(_ entity: Dish) {
        self.imageView.image = nil
        Task {
            imageView.image = await imageManager?.loadImage(url: entity.imageAddress)
        }
        
        title.text = entity.title
        body.text = entity.body
        reducedPrice.text = entity.reducedPrice
        originPrice.text = entity.originPrice
        eventStackView.addArrangedSubViews(UIFactory.makeEventBadges(entity.eventBadge))
    }
}
