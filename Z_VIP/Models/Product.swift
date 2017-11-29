//
//  Product.swift
//  Z_VIP
//
//  Created by Danh Dang on 11/29/17.
//  Copyright © 2017 com.zalora. All rights reserved.
//

import UIKit

class Product {
    
    var id: String
    var name: String
    var mainImageUrl: String
    var price: Double
    var brand: String
    
    init?(json: JSON) {
        guard json.error == nil else { return nil }
        id = json["id"].string ?? ""
        name = json["name"].string ?? ""
        mainImageUrl = json["mainImageUrl"].string ?? ""
        price = json["name"].double ?? 0.0
        brand = json["brand"].string ?? ""

    }
}
