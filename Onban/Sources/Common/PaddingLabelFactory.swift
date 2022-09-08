//
//  PaddingLabelFactory.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/08.
//

import UIKit

final class PaddingLabelFactory {
    
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
}
