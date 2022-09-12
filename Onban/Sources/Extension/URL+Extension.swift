//
//  URL+Extension.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/08.
//

import UIKit

extension URL {
    var asImage: UIImage? {
        guard let data = try? Data(contentsOf: self),
              let image = UIImage(data: data)
        else { return nil }
        
        return image
    }
}
