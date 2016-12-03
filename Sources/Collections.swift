//
//  Collections.swift
//  WarpKit
//
//  Created by Adam Nemecek on 10/1/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

public extension Sequence {
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

extension Sequence where Iterator.Element: Comparable {
    public var isSorted: Bool {
        return zip(self, sorted()).all { $0 == $1 }
    }
}



public extension Sequence where Iterator.Element: Hashable {
    //
    // dbj2
    //
    public var hashValue: Int {
        return reduce(5381) {
            (accu, current) -> Int in
            (accu << 5) &+ accu &+ current.hashValue
        }
    }
}

public extension Sequence where Iterator.Element: Hashable {
    public var unique: [Iterator.Element] {
        var s: Set<Iterator.Element> = []
        return filter { s.insert($0).inserted }
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

public extension Collection {
    public subscript (safe index: Index) -> Iterator.Element? {
//        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

public extension Collection where IndexDistance == Int {
    public var randomIndex: Index {
        let offset = randomInt(bound: count)
        return index(startIndex, offsetBy: offset)
    }

    /// Return a random element from the collection
    public var random: Iterator.Element? {
        guard !isEmpty else { return nil }
        return self[randomIndex]
    }

    public func shuffle() -> [Iterator.Element] {
        var c = Array(self)
        c.shuffleInPlace()
        return c
    }
}

public extension MutableCollection where Index == Int, IndexDistance == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }

        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

public extension BidirectionalCollection {
    /// Last valid index
    public var lastIndex: Index {
        return index(before: endIndex)
    }

    // Find last index s.t. predicate

	public func lastIndex(predicate: (Iterator.Element) -> Bool) -> Index? {
		var i = lastIndex
		while i != startIndex {
			if predicate(self[i]) {
				return i
			}
			i = index(before: i)
		}
		return nil
	}
}

public protocol SequenceConstructible: Sequence {
  init<S: Sequence>(_ seq: S) where S.Iterator.Element == Iterator.Element
}

extension Array: DefaultConstructible { }
extension Dictionary: DefaultConstructible { }
extension Set: DefaultConstructible { }



func ==<S: Sequence, T: Sequence>(lhs: S, rhs: T) -> Bool where S.Iterator.Element == T.Iterator.Element, S.Iterator.Element: Equatable {
    return zip(lhs, rhs).all { $0 == $1 }
}


