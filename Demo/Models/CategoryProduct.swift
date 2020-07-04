//
//  CategoryProduct.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import Foundation

struct Tax: Codable {
    var name: String?
    var value: Double?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case value = "value"
    }
    
    // MARK: - Decodable
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(Double.self, forKey: .value)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .value)
        try container.encode(name, forKey: .name)
    }
}

struct CategoryProduct: Codable {
    
    // MARK: - Object
    var id: Int?
    var name: String?
    var dateAdded: String?//Date?
    var variants : [Variant]?
    var tax: Tax?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case dateAdded = "date_added"
        case variants = "variants"
        case tax = "tax"
    }
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        return df
    }()
    
    // MARK: - Decodable
    init(from decoder: Decoder) throws {
        //self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        dateAdded = try values.decodeIfPresent(String.self, forKey: .dateAdded)
       // dateAdded = CategoryProduct.dateFormatter.date(from: date ?? "") ?? Date()
        tax = try values.decodeIfPresent(Tax.self, forKey: .tax)
        variants = try values.decodeIfPresent([Variant].self, forKey: .variants)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(dateAdded, forKey: .dateAdded)
        try container.encode(variants, forKey: .variants)
        try container.encode(tax, forKey: .tax)
    }
}
