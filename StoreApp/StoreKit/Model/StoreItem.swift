//
//  StoreItem.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/05.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

public struct StoreItem: Codable {
    public let detailHash: String
    public let image: String
    public let title: String
    public let description: String
    public let originalPrice: String?
    public let discountedPrice: String?
    public let deliveryTypes: [String]
    public let badges: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case image
        case title
        case description
        case originalPrice = "n_price"
        case discountedPrice = "s_price"
        case deliveryTypes = "delivery_type"
        case badges = "badge"
    }
}
