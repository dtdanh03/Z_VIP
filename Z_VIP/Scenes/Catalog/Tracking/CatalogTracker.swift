//
//  CatalogTracker.swift
//  Z_VIP
//
//  Created by Danh Dang on 12/1/17.
//  Copyright © 2017 com.zalora. All rights reserved.
//

import Foundation

protocol CatalogTracking: ScreenTracking {
    func trackProductTap(_ product: Product)
}

protocol ViewCatalogTracking: ViewScreenTracking {
    func trackProductTap(at index: Int)
}
