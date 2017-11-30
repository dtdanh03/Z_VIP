//
//  CatalogModels.swift
//  Z_VIP
//
//  Created by Danh Dang on 11/29/17.
//  Copyright (c) 2017 com.zalora. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Catalog {
    struct Request {}
    struct Response {
        var products: [Product]
    }
    struct ViewModel {
        struct DisplayedProduct {
            var name: String
            var mainImageUrl: String
        }
        var displayedProducts: [DisplayedProduct]
    }
}
