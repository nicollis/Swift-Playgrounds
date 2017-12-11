//: Playground - noun: a place where people can play

import Cocoa

struct StackIterator<T>: IteratorProtocol {
    typealias Element = T
    
    var stack: Stack<T>
    
    mutating func next() -> Element? {
        return stack.pop()
    }
}

struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
    
    func map<U>(_ f: (Element) -> U) -> Stack<U> {
        var mappedItems = [U]()
        for item in items {
            mappedItems.append(f(item))
        }
        return Stack<U>(items: mappedItems)
    }
    
    func filter(_ f: (Element) -> Bool) -> Stack<Element> {
        var filteredItems = [Element]()
        for item in items {
            if f(item) {
                filteredItems.append(item)
            }
        }
        return Stack<Element>(items: filteredItems)
    }
    
    func iterator() -> StackIterator<Element> {
        return StackIterator(stack: self)
    }
    
    mutating func pushAll<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        for item in sequence {
            self.push(item)
        }
    }
}

func findAll<C: Collection>(_ first: C, _ second: C.Element) -> [C.Index] where C.Element: Equatable{
    var indexLocations = [C.Index]()
    for offset in first.indices {
        if first[offset] == second {
            indexLocations.append(offset)
        }
    }
    return indexLocations
}


// MARK: Testing Code

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
var doubledStack = intStack.map{ 2 * $0 }

print(intStack.pop())
print(intStack.pop())
print(intStack.pop())
print(doubledStack.pop())
print(doubledStack.pop())

var stringStack = Stack<String>()
stringStack.push("Hello moto")
stringStack.push("Well that's easy to remember. 0118 999 88199 9119 725! ... 3!")

print(stringStack.pop())

var myStack = Stack<Int>()
myStack.pushAll([10,20,30])

var myFilteredStack = myStack.filter { (item) -> Bool in
    return (item > 15)
}

var myStackIterator = myStack.iterator()
while let value = myStackIterator.next() {
    print("got \(value)")
}

var myFilteredStackIterator = myFilteredStack.iterator()
while let value = myFilteredStackIterator.next() {
    print("got \(value)")
}

print(findAll([5,3,7,3,9], 3))
