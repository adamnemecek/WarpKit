//
//  Collections.swift
//  WarpKit
//
//  Created by Adam Nemecek on 10/1/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

extension Sequence {
    public func all(predicate: (Iterator.Element) -> Bool) -> Bool {
        for e in self where !predicate(e) {
            return false
        }
        return true
    }

    public func any(predicate: (Iterator.Element) -> Bool) -> Bool {
        for e in self where predicate(e) {
            return true
        }
        return false
    }

    public func none(predicate: (Iterator.Element) -> Bool) -> Bool {
        for e in self where predicate(e) {
            return false
        }
        return true
    }
}

extension RangeReplaceableCollection where Iterator.Element: ExpressibleByIntegerLiteral {
    /// Initialize array with zeroes, ~10x faster than append for array of size 4096
    ///
    /// - parameter count: Number of elements in the array
    ///

    public init(zeros count: Int) {
        self.init(repeating: 0, count: count)
    }
}

extension Sequence where Iterator.Element: Hashable {
    public var unique: [Iterator.Element] {
        var s: Set<Iterator.Element> = []
        return filter { s.insert($0).inserted }
    }
}

extension Collection where IndexDistance == Int {
    /// Return a random element from the collection
    public func random() -> Iterator.Element {
        let offset = Int(arc4random_uniform(UInt32(count.toIntMax())))
        return self[index(startIndex, offsetBy: offset)]
    }
}

extension Sequence where Iterator.Element: Hashable {
    //
    // dbj2
    //
    var hashValue: Int {
        return reduce(5381) {
            (accu, current) -> Int in
            (accu << 5) &+ accu &+ current.hashValue
        }
    }
}

public protocol DefaultConstructible {
    init()
}



