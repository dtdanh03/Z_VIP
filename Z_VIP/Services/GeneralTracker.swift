//
//  GeneralTracker.swift
//  Z_VIP
//
//  Created by Danh Dang on 12/1/17.
//  Copyright © 2017 com.zalora. All rights reserved.
//

import Foundation

class GeneralTracker: ScreenTracking {
    func trackOpenScreen(name: String) {
        print("Tracking screen name: \(name)")
    }
}

extension GeneralTracker: CatalogTracking {
    func trackProductTap(_ product: Product) {
        print("Tracking product tapped on catalog screen: \(product)")
    }
}
