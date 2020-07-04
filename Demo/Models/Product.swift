//
//  Product.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

struct Product: Codable {
    
    // MARK: - Object
    var id: Int?
    var viewCount: Int?
    var orderCount: Int?
    var shares: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case viewCount = "view_count"
        case orderCount = "order_count"
        case shares = "shares"
    }
    
    // MARK: - Decodable
    init(from decoder: Decoder) throws {        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        viewCount = try values.decodeIfPresent(Int.self, forKey: .viewCount)
        orderCount = try values.decodeIfPresent(Int.self, forKey: .orderCount)
        shares = try values.decodeIfPresent(Int.self, forKey: .shares)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(viewCount, forKey: .viewCount)
        try container.encode(orderCount, forKey: .orderCount)
        try container.encode(shares, forKey: .shares)
    }
}
