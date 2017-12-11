//
//  Person.swift
//  CyclicalAssets
//
//  Created by Nic Ollis on 12/10/17.
//  Copyright © 2017 Nic Ollis. All rights reserved.
//

import Foundation

class Person: CustomStringConvertible {
    let name: String
    let accountant = Accountant()
    var assets = [Asset]()
    
    var description: String {
        return "Person(\(name))"
    }
    
    init(name: String) {
        self.name = name
        
        accountant.netWorthChangedHandler = { [weak self] netWorth in
            self?.netWorthDidChange(to: netWorth)
            return
        }
    }
    
    deinit {
        print("\(self) is being deallocated")
    }
    
    func takeOwnership(of asset: Asset){
        accountant.gained(asset){
            asset.owner = self
            assets.append(asset)
        }
    }
    
    func giveUpOwnership(of asset: Asset) {
        accountant.lossed(asset){
            asset.owner = nil
            assets.drop(while: { (item) -> Bool in
                asset === item
            })
        }
    }
    
    func netWorthDidChange(to netWorth: Double) {
        print("The net worth of \(self) is now \(netWorth)")
    }
    
    func useNetWorthChangedHandler(handler: @escaping (Double) -> Void) {
        accountant.netWorthChangedHandler = handler
    }
}
