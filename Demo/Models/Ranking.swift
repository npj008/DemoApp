//
//  Ranking.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

struct Ranking: Codable {
    
    // MARK: - Object
    var products: [Product]?
    var ranking: String?
    
    enum CodingKeys: String, CodingKey {
        case products = "products"
        case ranking = "ranking"
    }
    
    // MARK: - Decodable
    init(from decoder: Decoder) throws {        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decodeIfPresent([Product].self, forKey: .products)
        ranking = try values.decodeIfPresent(String.self, forKey: .ranking)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(products, forKey: .products)
        try container.encode(ranking, forKey: .ranking)
    }
}
