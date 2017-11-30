//
//  ProductDetailInteractor.swift
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

protocol ProductDetailBusinessLogic {
    func fetchImageList(for request: ProductDetail.Request)
}

protocol ProductDetailDataStore {
    var product: Product { get set }
}

class ProductDetailInteractor: ProductDetailBusinessLogic, ProductDetailDataStore {
    var product: Product = Product()
    var presenter: ProductDetailPresentationLogic?
    var worker: ProductDetailWorker?
    
    func fetchImageList(for request: ProductDetail.Request) {
        worker = ProductDetailWorker()
        worker?.fetchImageList(for: request.product, { (result) in
            switch result {
            case .success(let imageUrls):
                self.presenter?.present(response: ProductDetail.Response(product: self.product, imageList: imageUrls))
            case .failure(_):
                break
            }
        })
    }
}
