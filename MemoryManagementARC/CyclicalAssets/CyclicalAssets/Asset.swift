//
//  Asset.swift
//  CyclicalAssets
//
//  Created by Nic Ollis on 12/10/17.
//  Copyright © 2017 Nic Ollis. All rights reserved.
//

import Foundation

class Asset: CustomStringConvertible {
    let name: String
    let value: Double
    weak var owner: Person?
    
    var description: String {
        return "Asset(\(name), worth \(value), \(owner != nil ? "owned by \(owner!)" : "not owned by anyone")"
    }
    
    init(name: String, value: Double) {
        self.name = name
        self.value = value
    }
    
    deinit {
        print("\(self) is being deallocated")
    }
}
