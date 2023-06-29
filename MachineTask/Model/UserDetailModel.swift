//
//  UserDetailModel.swift
//  MachineTask
//
//  Created by Djax on 29/06/23.
//

import Foundation

struct UserInfoDetail: Codable {
    var id: Int?
    var firstName, lastName, maidenName: String?
    var age: Int?
    var gender, email, phone, username: String?
    var password, birthDate: String?
    var image: String?
    var bloodGroup: String?
    var height: Int?
    var weight: Double?
    var eyeColor: String?
    var hair: Hair?
    var domain, ip: String?
    var address: Address?
    var macAddress, university: String?
    var bank: Bank?
    var company: Company?
    var ein, ssn, userAgent: String?
}

