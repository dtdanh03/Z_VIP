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
    static let products = [MockModels.product2, MockModels.product2]
}

class MockProductService: ProductService {
    var shouldReturnFailure = false
    static let mockImageList = ["a", "b", "c", "d"]
    
    init(shouldReturnFailure: Bool) {
        self.shouldReturnFailure = shouldReturnFailure
    }
    
    convenience init() {
        self.init(shouldReturnFailure: false)
    }
    
    func loadProducts(_ callback: @escaping (Result<Product>) -> Void) {
        let successResult = Result.success(MockModels.products)
        shouldReturnFailure ? callback(Result.failure("Load products error")) : callback(successResult)
        
    }
    
    func loadProductImage(for product: Product, callback: @escaping (Result<String>) -> Void) {
        let successResult = Result.success(MockProductService.mockImageList)
        shouldReturnFailure ? callback(Result.failure("Load image list error")) : callback(successResult)
    }
    
    func loadProductDescription(for product: Product, callback: @escaping (SingleResult<String>) -> Void) {
        let successResult = SingleResult.success("Product description")
        shouldReturnFailure ? callback(SingleResult.failure("Load product description error")) : callback(successResult)
    }
}

extension Product {
    static func catalogDisplayProduct(from product: Product) -> Catalog.ViewModel.DisplayedProduct {
        return Catalog.ViewModel.DisplayedProduct(name: product.name, mainImageUrl: product.mainImageUrl)
    }
    
    static func productDetailDisplayProduct(from product: Product) -> ProductDetail.ViewModel.DisplayProduct {
        var displayProduct = ProductDetail.ViewModel.DisplayProduct()
        displayProduct.name = product.name
        displayProduct.brand = product.brand
        displayProduct.price = "$ \(product.price)"
        return displayProduct
    }
}
