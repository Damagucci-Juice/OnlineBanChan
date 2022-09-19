//
//  MainCollectionReusableView.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit
import SnapKit
import Toaster

final class MainCollectionReusableView: UICollectionReusableView {
    
    private var itemCount: Int = 0
    
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
        attribute()
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
            $0.leading.trailing.equalToSuperview().inset(LayoutConstant.edgeSpacing)
        }
    }
    
    func setup(by index: Int, _ itemCount: Int) {
        self.itemCount = itemCount
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

extension MainCollectionReusableView {
    private func attribute() {
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Toast(text: "\(itemCount)개의 상품이 등록되어 있습니다.").show()
    }
}
