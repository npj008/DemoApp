//
//  DataResponse.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

struct DataResponse: Codable {
    
    // MARK: - Core Data Managed Object
    var categories: [Category]?
    var rankings: [Ranking]?
    
    enum CodingKeys: String, CodingKey {
        case categories = "categories"
        case rankings = "rankings"
    }
    
    // MARK: - Decodable
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([Category].self, forKey: .categories)
        rankings = try values.decodeIfPresent([Ranking].self, forKey: .rankings)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(categories, forKey: .categories)
        try container.encode(rankings, forKey: .rankings)
    }
}

