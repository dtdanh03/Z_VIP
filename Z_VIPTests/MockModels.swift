//
//  MockModels.swift
//  Z_VIPTests
//
//  Created by Danh Dang on 12/1/17.
//  Copyright © 2017 com.zalora. All rights reserved.
//

import Foundation
@testable import Z_VIP

struct MockModels {
    static let product1 = Product(id: "1", name: "Shoes", mainImageUrl: "Url1", price: "100.00", brand: "Zalora")
    static let product2 = Product(id: "2", name: "Shirt", mainImageUrl: "Url2", price: "200.00", brand: "Adidas")
}

extension Product {
    static func catalogDisplayProduct(from product: Product) -> Catalog.ViewModel.DisplayedProduct {
        return Catalog.ViewModel.DisplayedProduct(name: product.name, mainImageUrl: product.mainImageUrl)
    }
}
