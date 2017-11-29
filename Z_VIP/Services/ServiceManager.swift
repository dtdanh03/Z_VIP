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

class ServiceManager {
    
    //All services
    static let offline = OfflineService()
    
}

class OfflineService {
    func loadProducts(_ callback: @escaping (Result<Product>)->Void) {
        guard let path = Bundle.main.path(forResource: "Products", ofType: "json") else {
            callback(Result.failure("Cannot load products"))
            return
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            callback(Result.failure("Cannot read contents of file"))
            return
        }
        
        let json = try? JSON(data: data)
        guard let products = json?.array?.flatMap({ json in return Product(json: json) })  else {
            callback(Result.failure("Cannot parse Json"))
            return
        }
        
        callback(Result.success(products))
    }
}
