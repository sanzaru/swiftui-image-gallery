//
//  ImageHelper.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 30.10.20.
//

import UIKit

extension UIImage {
    /// Get a resized version of an image
    /// - Parameters:
    ///   - width: The destination width
    ///   - isOpaque: Optional Bool for setting opaque (default true)
    /// - Returns: The resized image
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
