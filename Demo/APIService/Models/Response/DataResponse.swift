//
//  DataResponse.swift
//  TrialTask
//
//  Created by Nikunj on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import CoreData

class Ranking: Codable {
    
    // MARK: - Core Data Managed Object
    var products: [Product]?
    var ranking: String?
    
    enum CodingKeys: String, CodingKey {
        case products = "products"
        case ranking = "ranking"
    }
    
    // MARK: - Decodable
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.products = try values.decodeIfPresent([Product].self, forKey: .products)
        self.ranking = try values.decodeIfPresent(String.self, forKey: .ranking)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(products, forKey: .products)
        try container.encode(ranking, forKey: .ranking)
    }
}

class Product: Codable {
    
    // MARK: - Core Data Managed Object
    var id: NSNumber?
    var viewCount: NSNumber?
    var orderCount: NSNumber?
    var shares: NSNumber?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case viewCount = "view_count"
        case orderCount = "order_count"
        case shares = "shares"
    }
    
    // MARK: - Decodable
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let idValue = try values.decodeIfPresent(Int.self, forKey: .id)
        self.id = NSNumber(value: idValue ?? 0)
        let viewCountValue = try values.decodeIfPresent(Int.self, forKey: .viewCount)
        self.viewCount = NSNumber(value: viewCountValue ?? 0)
        let orderCountValue = try values.decodeIfPresent(Int.self, forKey: .orderCount)
        self.orderCount = NSNumber(value: orderCountValue ?? 0)
        let sharesValue = try values.decodeIfPresent(Int.self, forKey: .shares)
        self.shares = NSNumber(value: sharesValue ?? 0)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id?.intValue, forKey: .id)
        try container.encode(viewCount?.intValue, forKey: .viewCount)
        try container.encode(orderCount?.intValue, forKey: .orderCount)
        try container.encode(shares?.intValue, forKey: .shares)
    }
}

class Variant: Codable {
    
    // MARK: - Core Data Managed Object
    var id: NSNumber?
    var color: String?
    var size: NSNumber?
    var price: NSNumber?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case color = "color"
        case size = "size"
        case price = "price"
    }
    
    // MARK: - Decodable
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let idValue = try values.decodeIfPresent(Int.self, forKey: .id)
        self.id = NSNumber(value: idValue ?? 0)
        self.color = try values.decodeIfPresent(String.self, forKey: .color)
        let sizeValue = try values.decodeIfPresent(Int.self, forKey: .size)
        self.size = NSNumber(value: sizeValue ?? 0)
        let priceValue = try values.decodeIfPresent(Int.self, forKey: .price)
        self.price = NSNumber(value: priceValue ?? 0)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id?.intValue, forKey: .id)
        try container.encode(color, forKey: .color)
        try container.encode(size?.intValue, forKey: .size)
        try container.encode(price?.intValue, forKey: .price)
    }
}

class Tax: Decodable {
    var name: String?
    var value: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case value = "value"
    }
    
    // MARK: - Decodable
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        value = try values.decodeIfPresent(Int.self, forKey: .value)
    }
}

class CategoryProduct: Codable {
    
    // MARK: - Core Data Managed Object
    var id: NSNumber?
    var name: String?
    var dateAdded: String?
    var variants : [Variant]?
//    var tax: Tax?
//    var taxValue: Int?
//    var taxName: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case dateAdded = "date_added"
        case variants = "variants"
//        case tax = "tax"
    }
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        return df
    }()
    
//    enum TaxKeys: String, CodingKey {
//        case name = "name"
//        case value = "value"
//    }
    
    // MARK: - Decodable
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let idValue = try values.decodeIfPresent(Int.self, forKey: .id)
        self.id = NSNumber(value: idValue ?? 0)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.dateAdded = try values.decodeIfPresent(String.self, forKey: .dateAdded)
        self.variants = try values.decodeIfPresent([Variant].self, forKey: .variants)
        //tax = try values.decodeIfPresent(Tax.self, forKey: .tax)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id?.intValue, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(dateAdded, forKey: .dateAdded)
        try container.encode(variants, forKey: .variants)
    }
}

class Category: Codable {
    
    // MARK: - Core Data Managed Object
    var childCategories : [Int]?
    var categoryId: NSNumber?
    var name: String?
    var products: [CategoryProduct]?
    
    enum CodingKeys: String, CodingKey {
        case childCategories = "child_categories"
        case categoryId = "id"
        case name = "name"
        case products = "products"
    }
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        childCategories = try values.decodeIfPresent([Int].self, forKey: .childCategories)
        let categoryIdValue = try values.decodeIfPresent(Int.self, forKey: .categoryId)
        categoryId = NSNumber(value: categoryIdValue ?? 0)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        products = try values.decodeIfPresent([CategoryProduct].self, forKey: .products)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(childCategories, forKey: .childCategories)
        try container.encode(categoryId?.intValue, forKey: .categoryId)
        try container.encode(name, forKey: .name)
        try container.encode(products, forKey: .products)
    }
}

class DataResponse: Codable {
    
    // MARK: - Core Data Managed Object
    var categories : [Category]?
    var rankings : [Ranking]?
    
    enum CodingKeys: String, CodingKey {
        case categories = "categories"
        case rankings = "rankings"
    }
    
    // MARK: - Decodable
    required init(from decoder: Decoder) throws {
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

