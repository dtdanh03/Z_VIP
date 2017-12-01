//
//  Protocol.swift
//  Z_VIP
//
//  Created by Danh Dang on 12/1/17.
//  Copyright © 2017 com.zalora. All rights reserved.
//

import Foundation

protocol ScreenTracking {
    func trackOpenScreen(name: String)
}

protocol ViewScreenTracking {
    func trackOpenScreen()
}
