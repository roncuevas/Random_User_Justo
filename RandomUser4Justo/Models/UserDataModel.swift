//
//  UserDataModel.swift
//  RandomUser4Justo
//
//  Created by user218634 on 8/27/22.
//

import Foundation

//User data model for JSON data
//Some lines are commented because we dont use them
struct UserDataModel: Decodable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let dob: Dob
    let phone: String
    let picture: Picture
    let login: Login
    //let registered: Dob
    //let cell: String
    //let id: ID
    //let nat: String
}

// MARK: - Dob
struct Dob: Codable {
    let date: String
    let age: Int
}

// MARK: - ID
struct ID: Codable {
    let name, value: String
}

// MARK: - Location
struct Location: Codable {
    let street: Street
    let city, state, country: String
    //let postcode: Int   Parameter eliminated because API returns Int and String types randomly causing conflicts
    let coordinates: Coordinates
    let timezone: Timezone
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String
}

// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset, timezoneDescription: String

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}

// MARK: - Login
struct Login: Codable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String
}

