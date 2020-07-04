//
//  Category.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

struct Category: Codable {
    
    // MARK: - Object
    var childCategories : [Int]?
    var categoryId: Int?
    var name: String?
    var products: [CategoryProduct]?
    
    enum CodingKeys: String, CodingKey {
        case childCategories = "child_categories"
        case categoryId = "id"
        case name = "name"
        case products = "products"
    }
    
    init(from decoder: Decoder) throws {        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        childCategories = try values.decodeIfPresent([Int].self, forKey: .childCategories)
        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        products = try values.decodeIfPresent([CategoryProduct].self, forKey: .products)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(childCategories, forKey: .childCategories)
        try container.encode(categoryId, forKey: .categoryId)
        try container.encode(name, forKey: .name)
        try container.encode(products, forKey: .products)
    }
}
