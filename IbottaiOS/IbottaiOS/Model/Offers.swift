//
//  Offers.swift
//  IbottaiOS
//
//  Created by Bharat Kumar on 4/17/21.
//

import Foundation

struct OfferRepresentation: Codable, Hashable {
    
    var id: String
    var imageURL: String?
    var name: String
    var description: String
    var terms: String
    var current_value: String?

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "url"
        case name
        case description
        case terms
        case current_value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        terms = try container.decode(String.self, forKey: .terms)
        current_value = try! container.decodeIfPresent(String.self, forKey: .current_value)
    }
}


