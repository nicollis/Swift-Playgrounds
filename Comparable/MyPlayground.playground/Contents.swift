//: Playground - noun: a place where people can play

import Cocoa

struct Point: Comparable {
    let x: Int
    let y: Int
    
    static func ==(lhs: Point, rhs: Point) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
    
    static func <(lhs: Point, rhs: Point) -> Bool {
        return (lhs.x < rhs.x) && (lhs.y < rhs.y)
    }
    
    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x+rhs.x, y: lhs.y+rhs.y)
    }
}

let a = Point(x: 3, y: 4)
let b = Point(x: 3, y: 4)
let abEqual = ( a == b )
let abNotEqual = ( a != b )
let c = Point(x: 2, y: 6)
let d = Point(x: 3, y: 7)

let cdEqual = ( c == d )
let cLessThanD = (c < d)

let cLessThanEqualD = ( c <= d )
let cGreaterThanD = ( c > d )
let cGreaterThanEqualD = ( c >= d )

let aPlusB = a + b

class Person: Equatable {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return (lhs.name == rhs.name) && (lhs.age == rhs.age)
    }
}

let p1 = Person(name: "Bob", age: 37)
let p2 = Person(name: "Sam", age: 35)

let people = [p1, p2]

people.index(of: p1)
