//
//  UserInfoModel.swift
//  MachineTask
//
//  Created by Djax on 29/06/23.
//

import Foundation

struct UserInfoModel: Codable {
    var users: [User]?
    var total, skip, limit: Int?
}

// MARK: - User
struct User: Codable {
    var id: Int?
    var firstName, lastName, maidenName: String?
    var age: Int?
    var gender: String?
    var email, phone, username, password: String?
    var birthDate: String?
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

// MARK: - Address
struct Address: Codable {
    var address, city: String?
    var coordinates: Coordinates?
    var postalCode, state: String?
}

// MARK: - Coordinates
struct Coordinates: Codable {
    var lat, lng: Double?
}

// MARK: - Bank
struct Bank: Codable {
    var cardExpire, cardNumber, cardType, currency: String?
    var iban: String?
}

// MARK: - Company
struct Company: Codable {
    var address: Address?
    var department, name, title: String?
}

// MARK: - Hair
struct Hair: Codable {
    var color: String?
    var type: String?
}
