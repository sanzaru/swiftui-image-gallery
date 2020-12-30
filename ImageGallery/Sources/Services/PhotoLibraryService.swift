//
//  PhotoLibraryService.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 01.11.20.
//

import UIKit

/// Helper class for saving images to the photo library
class PhotoLibraryService: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
        
    func writeToLibrary(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
