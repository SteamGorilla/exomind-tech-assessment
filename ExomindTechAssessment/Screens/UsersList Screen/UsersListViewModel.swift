//
//  UsersListViewModel.swift
//  ExomindTechAssessment
//
//  Created by Jeremy Papay on 12/01/2021.
//

import Foundation

class UsersListViewModel {

    // MARK: - Properties
    var users: Dynamic<[User]> = Dynamic([])

    // MARK: - Initialization
    func getUsers() {
        ApiService.getUsers { (users) in
            self.users.value = users
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(users)
                UserDefaults.standard.set(data, forKey: "users")
            } catch {
                print("Unable to Encode Array of Notes (\(error))")
            }
        }
    }

    func setStoredUsers() {
        if let data = UserDefaults.standard.data(forKey: "users") {
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data)
                self.users.value = users
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
    }
}
