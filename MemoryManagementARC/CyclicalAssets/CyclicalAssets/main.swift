//
//  main.swift
//  CyclicalAssets
//
//  Created by Nic Ollis on 12/10/17.
//  Copyright © 2017 Nic Ollis. All rights reserved.
//

import Foundation

var bob: Person? = Person(name: "Bob")
print("Created: \(bob)")

var tom: Person? = Person(name: "Tom")
print("Created: \(tom)")

var laptop: Asset? = Asset(name: "Shiny Laptop", value: 1_500.0)
var hat: Asset? = Asset(name: "10-gallon Hat", value: 175.0)
var backpack: Asset? = Asset(name: "SF Bags amazing Backpack", value: 400.0)

bob?.useNetWorthChangedHandler(handler: { (netWorth) in
    print("Bob's net worth is now \(netWorth)")
})
bob?.takeOwnership(of: laptop!)
tom?.takeOwnership(of: laptop!)
bob?.takeOwnership(of: hat!)

print("The owner of the laptop should be Bob and is, \(laptop!.owner)")

bob?.giveUpOwnership(of: laptop!)

print("While Bob is alive, hat's owner is \(hat!.owner)")
bob = nil
print("the bob variable is now \(bob)")
print("After Bob dies, hat's owner is \(hat!.owner)")

laptop = nil
hat = nil
backpack = nil

tom = nil
