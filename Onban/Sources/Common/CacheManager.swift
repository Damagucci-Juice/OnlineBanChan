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
    
    /// 아래의 질문에 답하려면 Encode 된 이미지와 Decode 된 이미지의 차이점에 대해 이야기할 수 있어야 한다.
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
    
    private lazy var cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    
    init(config: Config = Config.defaultConfig) {
        self.config = config
    }
}

extension CacheManager: ImageCacheType {
    
    func image(for url: URL) -> UIImage? {
        let imageName = url.lastPathComponent as NSString
        if let destination = cachesDirectory?.appendingPathComponent(imageName as String),
           FileManager.default.fileExists(atPath: destination.path),
           let image = UIImage(contentsOfFile: destination.path) {
            return image
        }
        
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
        guard let image = image else { return removeImage(for: url) }
        let imageName = url.lastPathComponent as NSString
        let decodedImage = image.decodedImage()
        
        guard let destination = cachesDirectory?.appendingPathComponent(imageName as String)
        else { return removeImage(for: url) }
        do {
            try FileManager.default.copyItem(at: url, to: destination)
        } catch {
            assert(false)
        }
        
        imageCache.setObject(image, forKey: imageName)
        decodedImageCache.setObject(decodedImage, forKey: imageName, cost: decodedImage.diskSize)
    }
    
    func removeImage(for url: URL) {
        let imageName = url.lastPathComponent as NSString
        imageCache.removeObject(forKey: imageName)
        decodedImageCache.removeObject(forKey: imageName)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            assert(false)
        }
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
