//
//  UIStackView+Extension.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit

extension UIStackView {
    func addArrangedSubViews(_ views: [UIView]) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
