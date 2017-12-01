//
//  CatalogInteractor.swift
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

protocol CatalogBusinessLogic {
    func fetchProducts()
}

protocol CatalogDataStore {
    var products: [Product] { get }
}

class CatalogInteractor: CatalogBusinessLogic, CatalogDataStore{
    
    var presenter: CatalogPresentationLogic?
    var worker = CatalogWorker()
    var products: [Product] = []
    
    func fetchProducts() {
        worker.fetchProduct({ [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let products):
                strongSelf.products = products
                strongSelf.presenter?.present(products: Catalog.Response(products: products))
            case .failure(let message):
                strongSelf.presenter?.present(error: Error(message: message))
            }
        })
    }
}
