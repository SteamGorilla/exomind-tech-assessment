//
//  PhotosListViewModel.swift
//  ExomindTechAssessment
//
//  Created by Jeremy Papay on 18/01/2021.
//

import Foundation

class PhotosListViewModel {

    // MARK: - Properties
    var photos: Dynamic<[Photo]> = Dynamic([])

    func getPhotos(with albumId: Int) {
        ApiService.getPhotos(with: albumId) { (photos) in
            self.photos.value = photos
        }
    }
}
