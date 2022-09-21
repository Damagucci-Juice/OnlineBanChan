//
//  ImageCacheType.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/08.
//

import UIKit

protocol ImageCacheType: AnyObject {
    func image(for url: URL) -> UIImage?
    func insertImage(_ image: UIImage?, for url: URL)
    func removeImage(for url: URL)
    func removeAllImages()
    subscript(_ key: URL) -> UIImage? { get set }
}
