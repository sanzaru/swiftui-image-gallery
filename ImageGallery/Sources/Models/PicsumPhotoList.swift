//
//  PhotoListModel.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 29.10.20.
//

import SwiftUI

class PicsumPhotoList: ObservableObject {
    @Published var list: [PicsumPhoto] = [PicsumPhoto]()
    
    func fetch(completion: @escaping (Bool) -> Void) {
        PicsumPhotoService.shared.fetchPhotos() { data in
            DispatchQueue.main.async {
                self.list = data.sorted { $0.metaData.id < $1.metaData.id }
                completion(!self.list.isEmpty)
            }
        }
    }
}
