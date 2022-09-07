//
//  MainCollectionReusableView.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit
import SnapKit

final class MainCollectionReusableView: UICollectionReusableView {
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.textLargeRegular
        label.textColor = UIColor.grey1
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This initializer shouldn't be used")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(title)
        
        title.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(LayoutConstant.spacingOfSection)
            $0.leading.trailing.equalToSuperview().inset(LayoutConstant.spacing)
        }
    }
    
    func setup(by index: Int) {
        switch index {
        case 0:
            title.text = """
                        모두가 좋아하는
                        든든한 메인 요리
                        """
        case 1:
            title.text = """
                        정성이 담긴
                        뜨끈뜨끈 국물 요리
                        """
        case 2:
            title.text = """
                        식탁을 풍성하게 하는
                        정갈한 밑반찬
                        """
        default:
            assert(false)
        }
    }
}
