//
//  Person.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 08.07.2022.
//

import Foundation

struct Person: Encodable, Hashable, Decodable {
    var fullName: String
    //var email: String
    var city: String?
    var iin: String?
    var roleID: Int
    var dateOfBirth: String?
    var school: String?
    
  //  var graduationYear: String?
    var phoneNumber: String
    var university: String?
    var aboutMe: String?
}

struct UserInfo: Encodable {
    var city: String
    var school: String
    var phoneNumber: String
    var university: String?
    var dateOfBirth: String
    var iin: String
}

struct Majors: Encodable {
    var majors: [Int]
}

struct Mentor: Hashable {
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
    var image: String
}

struct MentorIds: Decodable {
    var ids: [Int]
}

struct MenteeIds: Decodable {
    var ids: [Int]
}

struct MentorCard: Decodable, Encodable {
    var fullName: String
    var subjectList: [Int]
    var university: String
}

struct MenteeCards {
    var fullName: String
    var subjectList: [Int]
    var university: String?
}
