//
//  PaddingLabel.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit

final class PaddingLabel: UILabel {
    var padding = UIEdgeInsets.zero
    var isCapsule = false

    override func drawText(in rect: CGRect) {
        let paddingRect = rect.inset(by: padding)
        super.drawText(in: paddingRect)
        
        if isCapsule {
            layer.cornerRadius = rect.height / 2
        }
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}

extension PaddingLabel {
    var asEventBadge: Self {
        self.textColor = UIColor.white
        self.font = UIFont.caption
        self.padding = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
        self.isCapsule = true
        self.clipsToBounds = true
        return self
    }
    
    func setupAttribute(_ event: EventBadge) {
        switch event {
        case .luanchingSpecialPrice:
            self.backgroundColor = UIColor.primary1
        case .mainSpecialPrice:
            self.backgroundColor = UIColor.primary2
        case .eventSpecialPrice:
            self.backgroundColor = UIColor.primary3
        }
        self.text = event.rawValue
    }
}
