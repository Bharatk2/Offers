//
//  Offers.swift
//  IbottaiOS
//
//  Created by Bharat Kumar on 4/17/21.
//

import Foundation
struct Offers: Codable {
    var offers: [Offer]
struct Offer: Codable {
    var id: String
    var imageURL: String
    var name: String
    var description: String
    var terms: String
    var cashBack: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "url"
        case name
        case description
        case terms
        case cashBack = "current_value"
    }
    
     init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        terms = try container.decode(String.self, forKey: .terms)
        cashBack = try container.decode(String.self, forKey: .cashBack)
    }
}

}
