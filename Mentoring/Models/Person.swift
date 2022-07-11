//
//  Person.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 08.07.2022.
//

import Foundation

struct Person: Encodable {
    var fullName: String
    var email: String
    var city: String?
    var iin: String?
    var role: String
    var dateOfBirthday: String?
    var school: String?
    var graduationYear: String?
    var phoneNumber: String
    var university: String
}

struct UserInfo: Encodable {
    var city: String
    var school: String
    var phoneNumber: String
    var university: String?
    var dateOfBirth: String
    var iin: String
}

//struct Major: Encodable {
//    var major: Int
//}

struct Majors: Encodable {
    var majors: [Int]
}