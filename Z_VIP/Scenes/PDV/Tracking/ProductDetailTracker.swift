//
//  ProductDetailTracker.swift
//  Z_VIP
//
//  Created by Danh Dang on 12/3/17.
//  Copyright © 2017 com.zalora. All rights reserved.
//

import Foundation

protocol ProductDetailTracking: ScreenTracking {
    func trackTapDetailButton()
}

protocol ViewProductDetailTracking: ViewScreenTracking {
    func trackTapDetailButton()
}
