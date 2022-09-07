//
//  UIColor+Extension.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit

extension UIColor {
    static let primary1 = color(r: 0, g: 102, b: 214)
    static let primary2 = color(r: 0, g: 122, b: 255)
    static let primary3 = color(r: 128, g: 188, b: 255)
    
    static let black = color(r: 1, g: 1, b: 1)
    static let grey1 = color(r: 79, g: 79, b: 79)
    static let grey2 = color(r: 130, g: 130, b: 130)
    static let grey3 = color(r: 224, g: 224, b: 224)
    static let grey4 = color(r: 245, g: 245, b: 247)
    
    static let white = color(r: 255, g: 255, b: 255)

    
    private static func color(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
        UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}
