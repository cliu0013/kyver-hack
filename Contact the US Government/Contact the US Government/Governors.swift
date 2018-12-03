import Foundation

struct Representative: Codable {
    var address: [Address]
    var channels: [Channel]
    var name: String
    var party: String
    var phones: [String]
    var photoUrl: String
    var urls: [String]
}

struct RepresentativeResponse: Codable {
    var officials: [Representative]
}

struct Senator: Codable {
    var address: [Address]
    var channels: [Channel]
    var name: String
    var party: String
    var phones: [String]
    var photoUrl: String
    var urls: [String]
}

struct SenatorResponse: Codable {
    var officials: [Senator]
}

struct Address: Codable {
    var city: String
    var line1: String
    var state: String
    var zip: String
}

struct Channel: Codable {
    var id: String
    var type: String
}


