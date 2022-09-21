//
//  PaddingLabelFactory.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/08.
//

import UIKit
import SnapKit

final class UIFactory {
    
    static func makeEventBadges(_ events: [EventBadge]?) -> [PaddingLabel] {
        var result: [PaddingLabel] = []
        
        if let events = events {
            events.forEach { event in
                let label = PaddingLabel().asEventBadge
                label.setupAttribute(event)
                result.append(label)
            }
        }
        
        return result
    }
    
    static func makeAttributedString(_ string: String) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: string)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: 2,
            range: NSRange(location: 0, length: attributeString.length)
        )
        return attributeString
    }
    
    static func makeDividingLine() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.grey3
        return view
    }
}
