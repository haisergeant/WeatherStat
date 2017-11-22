//
//  UIImage+Utils.swift
//  WeatherStat
//
//  Created by Le Thanh Hai on 11/23/17.
//  Copyright © 2017 haile. All rights reserved.
//

import Foundation
import UIKit

extension CGSize {
    public init(square: CGFloat) {
        self.init(width: square, height: square)
    }
}

extension UIImage {
    public func brush(withColor color: UIColor) -> UIImage {
        var newImage = self.withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(self.size, false, newImage.scale)
        color.set()
        
        newImage.draw(in: CGRect(origin: .zero, size: self.size))
        newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    public func resize(newWidth: CGFloat) -> UIImage {
        let size = CGSize(square: newWidth)
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /**
     Will generate an image to the size provided from the image if failed to generate from the image then will take the color given and generate an image with that color
     */
    public class func generateImage(from image: UIImage?, toSize size: CGSize, color: UIColor = .clear) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        var generatedImage: UIImage?
        if let context = UIGraphicsGetCurrentContext() {
            imageView.layer.render(in: context)
            generatedImage = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
        if let image = generatedImage {
            return image
        } else {
            return UIImage().brush(withColor: color)
        }
    }
}
