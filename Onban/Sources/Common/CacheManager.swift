//
//  CacheManager.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/08.
//

import UIKit

final class CacheManager {
    
    struct Config {
        let countLimit: Int
        let memoryLimit: Int
        
        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100)
    }
    
    static let shared = CacheManager()
    
    private let config: Config
    
    // TODO: - 1 lv cache, 2 lv cache 를 나눠서 얻는 효용이 무엇인가?
    // 1st level cache, that contains **encoded** images
    private lazy var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = config.countLimit
        return cache
    }()
    
    // 2nd level cache, that contains **decoded** images
    private lazy var decodedImageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    
//    private lazy var cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    
    init(config: Config = Config.defaultConfig) {
        self.config = config
    }
}

extension CacheManager: ImageCacheType {
    
    func image(for url: URL) -> UIImage? {
        let imageName = url.lastPathComponent as NSString
        if let decodedImage = decodedImageCache.object(forKey: imageName) {
            return decodedImage
        }
        // search for image data
        if let image = imageCache.object(forKey: imageName) {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(decodedImage, forKey: imageName, cost: decodedImage.diskSize)
            return decodedImage
        }
        return nil
    }
    
    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else {
            return removeImage(for: url)
        }
        let imageName = url.lastPathComponent as NSString
        let decodedImage = image.decodedImage()
        
        imageCache.setObject(image, forKey: imageName)
        decodedImageCache.setObject(decodedImage, forKey: imageName, cost: decodedImage.diskSize)
    }
    
    func removeImage(for url: URL) {
        let imageName = url.lastPathComponent as NSString
        imageCache.removeObject(forKey: imageName)
        decodedImageCache.removeObject(forKey: imageName)
    }
    
    func removeAllImages() {
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
    }
    
    subscript(key: URL) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
    
}
