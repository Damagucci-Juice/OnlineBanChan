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
