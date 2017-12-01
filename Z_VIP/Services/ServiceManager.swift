//
//  ServiceManager.swift
//  Z_VIP
//
//  Created by Danh Dang on 11/29/17.
//  Copyright © 2017 com.zalora. All rights reserved.
//

import Foundation

enum Result<T> {
    case success([T])
    case failure(String)
}

enum SingleResult<T> {
    case success(T)
    case failure(String)
}

class ServiceManager {
    
    //All services
    static let product = JSONProductService()
    
}

protocol ProductService {
    func loadProducts(_ callback: @escaping (Result<Product>)->Void)
    func loadProductImage(for product: Product, callback: @escaping (Result<String>)->Void)
    func loadProductDescription(for product: Product, callback: @escaping (SingleResult<String>)->Void)
}

class JSONProductService: ProductService {
    
    fileprivate func loadJson(forResource name: String, ofType type: String) -> JSON? {
        guard let path = Bundle.main.path(forResource: name, ofType: type),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            let json = try? JSON(data: data) else {
                return nil
        }
        return json
    }
    
    func loadProducts(_ callback: @escaping (Result<Product>)->Void) {
        guard let json = loadJson(forResource: "Products", ofType: "json") else {
            callback(Result.failure("Cannot load resource"))
            return
        }
        
        guard let products = json.array?.flatMap({ json in return Product(json: json) })  else {
            callback(Result.failure("Cannot parse Json"))
            return
        }
        
        callback(Result.success(products))
    }
    
    func loadProductImage(for product: Product, callback: @escaping (Result<String>)->Void) {
        guard let json = loadJson(forResource: "ImageList", ofType: "json") else {
            callback(Result.failure("Cannot load resource"))
            return
        }
        
        guard let imageList = json.array?.flatMap({ json in return json.string })  else {
            callback(Result.failure("Cannot parse Json"))
            return
        }
        
        callback(Result.success(imageList))
    }
    
    func loadProductDescription(for product: Product, callback: @escaping (SingleResult<String>)->Void) {
        guard let path = Bundle.main.path(forResource: "ProductDescription", ofType: "json"),
            let description = try? String.init(contentsOfFile: path) else {
                callback(SingleResult.failure("Cannot read data"))
                return
        }
        
        callback(SingleResult.success(description))
    }
    
}
