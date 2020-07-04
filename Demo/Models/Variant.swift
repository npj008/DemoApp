//
//  Variant.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

struct Variant: Codable {
    
    // MARK: - Object
    var id: Int?
    var color: String?
    var size: Int?
    var price: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case color = "color"
        case size = "size"
        case price = "price"
    }
    
    // MARK: - Decodable
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(color, forKey: .color)
        try container.encode(size, forKey: .size)
        try container.encode(price, forKey: .price)
    }
}
