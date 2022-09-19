//
//  UIImage+Extension.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/08.
//

import UIKit

extension UIImage {
    
    var diskSize: Int {
        return self.jpegData(compressionQuality: 1)?.count ?? 0
    }
    
    func decodedImage() -> UIImage {
        guard let cgImage = cgImage else { return self }
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let context = CGContext(
            data: nil,
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: 8,
            bytesPerRow: cgImage.bytesPerRow,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
        )
        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        
        guard let decodedImage = context?.makeImage() else { return self }
        return UIImage(cgImage: decodedImage)
    }
    
}
