//
//  CatalogWorker.swift
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

protocol CatalogWorkerProtocol {
    func fetchProduct(_ callback: @escaping (Result<Product>)->Void)
}

class CatalogWorker: CatalogWorkerProtocol {
    
    var productService: ProductService
    
    init(productService: ProductService) {
        self.productService = productService
    }
    
    convenience init() {
        self.init(productService: ServiceManager.product)
    }
    
    func fetchProduct(_ callback: @escaping (Result<Product>)->Void) {
        productService.loadProducts { (result) in
            callback(result)
        }
    }
}
