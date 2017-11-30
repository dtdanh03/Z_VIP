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
    var price: String
    var brand: String
    
    init() {
        id = ""
        name = ""
        mainImageUrl = ""
        price = ""
        brand = ""
    }
    
    init?(json: JSON) {
        guard json.error == nil else { return nil }
        id = json["id"].string ?? ""
        name = json["name"].string ?? ""
        mainImageUrl = json["mainImageUrl"].string ?? ""
        price = json["price"].string ?? ""
        brand = json["brand"].string ?? ""
    }
}
