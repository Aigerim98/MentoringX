//
//  Registration.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 11.07.2022.
//

import Foundation

struct Registration: Encodable {
    var fullName: String
    var email: String
    var password: String
    var role: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "fullName"
        case email = "email"
        case password = "password"
        case role = "role"
    }
}

struct ProcessRegistration: Encodable {
    var email: String
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}
