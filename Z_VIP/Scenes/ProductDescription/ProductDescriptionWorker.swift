//
//  ProductDescriptionWorker.swift
//  Z_VIP
//
//  Created by Danh Dang on 11/30/17.
//  Copyright (c) 2017 com.zalora. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProductDescriptionProtocol {
    func fetchProductDescription(for product: Product, _ callback: @escaping (SingleResult<String>)->Void)
}

class ProductDescriptionWorker: ProductDescriptionProtocol {
    var productService: ProductService
    
    init(productService: ProductService) {
        self.productService = productService
    }
    
    convenience init() {
        self.init(productService: ServiceManager.product)
    }
    
    func fetchProductDescription(for product: Product, _ callback: @escaping (SingleResult<String>)->Void) {
        productService.loadProductDescription(for: product) { (result) in
            callback(result)
        }
    }
}
