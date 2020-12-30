//
//  PicsumPhotoService.swift
//  ImageGallery
//
//  Created by Martin Albrecht on 29.10.20.
//

import SwiftUI
import Combine


struct PicsumPhotoJSON: Decodable, Hashable {
    var id: String
    var author: String
    var width: Int
    var height: Int
    var url: String
    var downloadUrl: String
}


class PicsumPhotoService {
    static let shared = PicsumPhotoService()
    
    let baseUrl = "https://picsum.photos/v2"
    let photoBaseUrl = "https://picsum.photos/id"
    
    private var cancellable: AnyCancellable?
}


extension PicsumPhotoService {
    func fetchPhotos(completion: @escaping ([PicsumPhoto]) -> Void) {
        var photoList = [PicsumPhoto]()
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: "\(baseUrl)/list")!)
            .retry(1)
            .map { $0.data }
            .decode(type: [PicsumPhotoJSON].self, decoder: decoder)
            .flatMap { json -> AnyPublisher<[PicsumPhoto], Error> in
                let photos = json.compactMap { self.photoData(for: $0) }
                return Publishers.MergeMany(photos)
                                .collect()
                                .eraseToAnyPublisher()
            }
            .sink(
                receiveCompletion: { _ in
                    completion(photoList)
                }
            ) { photos in
                photoList.append(contentsOf: photos)
            }
    }
    
    private func photoData(for json: PicsumPhotoJSON) -> AnyPublisher<PicsumPhoto, Error> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: json.downloadUrl)!)
            .retry(1)
            .mapError { $0 as Error }
            .map { PicsumPhoto(metaData: json, image: UIImage(data: Data($0.data))!) }
            .eraseToAnyPublisher()
    }
}
