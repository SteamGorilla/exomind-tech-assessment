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
}
