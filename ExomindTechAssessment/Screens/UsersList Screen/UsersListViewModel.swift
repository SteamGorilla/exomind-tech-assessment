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
        }
    }
}
