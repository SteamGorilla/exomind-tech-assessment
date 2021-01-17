//
//  User.swift
//  ExomindTechAssessment
//
//  Created by Jeremy Papay on 12/01/2021.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let phone: String
    let email: String
    let website: String
}
