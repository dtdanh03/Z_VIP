//
//  Product.swift
//  Z_VIP
//
//  Created by Danh Dang on 11/29/17.
//  Copyright © 2017 com.zalora. All rights reserved.
//

import UIKit

class Product: Equatable {
    
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
    
    init(id: String, name: String, mainImageUrl: String, price: String, brand: String) {
        self.id = id
        self.name = name
        self.mainImageUrl = mainImageUrl
        self.price = price
        self.brand = brand
    }
    
    init?(json: JSON) {
        guard json.error == nil else { return nil }
        id = json["id"].string ?? ""
        name = json["name"].string ?? ""
        mainImageUrl = json["mainImageUrl"].string ?? ""
        price = json["price"].string ?? ""
        brand = json["brand"].string ?? ""
    }
    
    static func ==(product1: Product, product2: Product) -> Bool {
        return product1.id == product2.id
            && product1.name == product2.name
            && product1.mainImageUrl == product2.mainImageUrl
            && product1.brand == product2.brand
            && product1.price == product2.price
    }
}
