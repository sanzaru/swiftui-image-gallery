//
//  PicsumPhoto.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 29.10.20.
//

import SwiftUI

class PicsumPhoto: ObservableObject {
    @Published var favorite: Bool = false
    
    let metaData: PicsumPhotoJSON
    let image: UIImage
    var thumb: UIImage {
        image.resized(toWidth: 600) ?? UIImage(systemName: "xmark.octagon")!
    }
    
    init(metaData: PicsumPhotoJSON, image: UIImage, favorite: Bool = false) {
        self.metaData = metaData
        self.image = image
        self.favorite = PicsumFavoriteService.shared.isFavorite(by: metaData.id)
    }
    
    func toggleFavorite() {
        favorite.toggle()
        
        if favorite {
            PicsumFavoriteService.shared.add(by: metaData.id)
        } else {
            PicsumFavoriteService.shared.delete(by: metaData.id)
        }
    }
}

// Hashable
extension PicsumPhoto: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(metaData.id)
        hasher.combine(metaData.author)
    }
}

// Equatable
extension PicsumPhoto {
    static func == (lhs: PicsumPhoto, rhs: PicsumPhoto) -> Bool {
        lhs.metaData.id == rhs.metaData.id
    }
}


// Chucked array of photos
extension Array where Element: PicsumPhoto {
    func chunked(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}

