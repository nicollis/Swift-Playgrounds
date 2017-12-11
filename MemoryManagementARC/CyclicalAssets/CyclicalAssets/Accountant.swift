//
//  Accountant.swift
//  CyclicalAssets
//
//  Created by Nic Ollis on 12/10/17.
//  Copyright © 2017 Nic Ollis. All rights reserved.
//

import Foundation

class Accountant {
    typealias NetWorthChanged = (Double) -> Void
    
    var netWorthChangedHandler: NetWorthChanged? = nil
    var netWorth: Double = 0.0 {
        didSet {
            netWorthChangedHandler?(netWorth)
        }
    }
    
    func gained(_ asset: Asset, completion: () -> Void) {
        if asset.owner == nil {
            netWorth += asset.value
            completion()
        }
    }
    
    func lossed(_ asset: Asset, completion: () -> Void) {
        netWorth -= asset.value
        completion()
    }
}
