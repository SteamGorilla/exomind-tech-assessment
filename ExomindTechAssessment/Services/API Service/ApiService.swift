//
//  ApiService.swift
//  ExomindTechAssessment
//
//  Created by Jeremy Papay on 12/01/2021.
//

import Foundation

class ApiService {

    private static let usersURL = URL(string: "https://jsonplaceholder.typicode.com/users")

    static func getUsers(completion: @escaping ([User]) -> Void) {
       let task = URLSession.shared.dataTask(with: usersURL!) { (data, _, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let usersData = try jsonDecoder.decode([User].self, from: data)
                    completion(usersData)
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }

    static func getAlbums(with userId: Int, completion: @escaping ([Album]) -> Void) {
       let albumsURL = URL(string: "https://jsonplaceholder.typicode.com/users/\(userId)/albums")

       let task = URLSession.shared.dataTask(with: albumsURL!) { (data, _, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let albumsData = try jsonDecoder.decode([Album].self, from: data)
                    completion(albumsData)
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }

    static func getPhotos(with albumId: Int, completion: @escaping ([Photo]) -> Void) {
        let photosURL = URL(string: "https://jsonplaceholder.typicode.com/users/1/photos?albumId=\(albumId)")

        let task = URLSession.shared.dataTask(with: photosURL!) { (data, _, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let photosData = try jsonDecoder.decode([Photo].self, from: data)
                    completion(photosData)
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
