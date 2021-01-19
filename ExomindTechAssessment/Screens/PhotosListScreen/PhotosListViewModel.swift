//
//  PhotosListViewModel.swift
//  ExomindTechAssessment
//
//  Created by Jeremy Papay on 18/01/2021.
//

import Foundation
import UIKit

class PhotosListViewModel {

    // MARK: - Properties
    var photos: Dynamic<[Photo]> = Dynamic([])

    // MARK: - Cache
    let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)

    func loadImage(with photoUrl: String, completion: @escaping (UIImage?) -> Void) {
        utilityQueue.async {
            let url = URL(string: photoUrl)!

            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)

            DispatchQueue.main.async {
                completion(image)
            }
        }
    }

    func getPhotos(with albumId: Int) {
        ApiService.getPhotos(with: albumId) { (photos) in
            self.photos.value = photos
        }
    }
}
