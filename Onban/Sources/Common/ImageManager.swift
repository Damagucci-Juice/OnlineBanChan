//
//  ImageManager.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/08.
//

import UIKit

protocol ImageManagable {
    func loadImage(url: URL) async -> UIImage?
}

final class ImageManager {
    
    private let backgroundQueue = DispatchQueue.global(qos: .background)
    private let cache: CacheManager
    static let shared = ImageManager()
    
    init(cache: CacheManager = CacheManager.shared) {
        self.cache = cache
    }
}

extension ImageManager: ImageManagable {
    
    func loadImage(url: URL) async -> UIImage? {
        if let cachedImage = self.cache[url] {
            return cachedImage
        }
        
        let result = Task { () -> UIImage?  in
            guard (try? await URLSession.shared.download(from: url)) != nil
            else { return nil }
            
            self.cache.insertImage(url.asImage, for: url)
            return url.asImage
        }
        
        return await result.value
    }
}
