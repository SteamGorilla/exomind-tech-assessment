//
//  AlbumsListViewModel.swift
//  ExomindTechAssessment
//
//  Created by Jeremy Papay on 18/01/2021.
//

import Foundation

class AlbumsListViewModel  {

    // MARK: - Properties
    var albums: Dynamic<[Album]> = Dynamic([])

    func getAlbums(with userId: Int) {
        ApiService.getAlbums(with: userId) { (albums) in
            self.albums.value = albums
        }
    }
}
