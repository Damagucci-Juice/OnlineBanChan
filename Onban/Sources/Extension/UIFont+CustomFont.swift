//
//  UIFont+CustomFont.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit

extension UIFont {
    
    static let textLargeRegular = sfProFont(size: 32, isBold: false)
    static let textMediumRegular = sfProFont(size: 18, isBold: false)
    static let textSmallRegular = sfProFont(size: 14, isBold: false)
    
    static let textLargeBold = sfProFont(size: 32, isBold: true)
    static let textMediumBold = sfProFont(size: 18, isBold: true)
    static let textSmallBold = sfProFont(size: 14, isBold: true)
    
    static let caption = sfProFont(size: 12, isBold: true)

    private static func sfProFont(size: CGFloat, isBold: Bool) -> UIFont {
        let fontType: String = isBold ? "SFProDisplay-Bold" : "SFProDisplay-Regular"
        guard let customFont = UIFont(name: fontType, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
}
